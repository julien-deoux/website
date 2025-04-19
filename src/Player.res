open WebAPI

%%raw(`import soundtrack from './soundtrack.mp3';`)
@val external soundtrack: string = "soundtrack"

type track = {
  start: unit => unit,
  stop: unit => unit,
  onEnded: (Dom.event => unit) => unit,
}

type queue = {
  current: ref<track>,
  next: ref<track>,
  timeout: ref<option<timeoutId>>,
}

let instanciatePlayer = async () => {
  let trackLength = 292571
  // let trackLength = 71000

  let res = await fetch(soundtrack)
  let audioData = await Response.arrayBuffer(res)
  let ctx = AudioContext.make()
  let buffer = await ctx->AudioContext.decodeAudioData(~audioData)

  let destinationNode = ctx.destination->AudioDestinationNode.asAudioNode
  let context = AudioContext.asBaseAudioContext(ctx)

  let createTrack = () => {
    let bsn = AudioBufferSourceNode.make(
      ~context,
      ~options={
        buffer: Null.Value(buffer),
      },
    )
    let gain = GainNode.make(
      ~context,
      ~options={
        gain: 0.3,
      },
    )
    let _ = gain->GainNode.connect(~destinationNode)
    let _ = bsn->AudioBufferSourceNode.connect(~destinationNode=gain->GainNode.asAudioNode)
    bsn->AudioBufferSourceNode.addEventListener(EventAPI.Ended, () => {
      gain->GainNode.disconnect
      bsn->AudioBufferSourceNode.disconnect
    })
    {
      start: () => {
        AudioBufferSourceNode.start(bsn)
      },
      stop: () => {
        let endTime = ctx.currentTime +. 0.05
        let _ = AudioParam.linearRampToValueAtTime(gain.gain, ~value=0.0, ~endTime)
        AudioBufferSourceNode.stop(bsn, ~when_=endTime)
      },
      onEnded: cb => bsn->AudioBufferSourceNode.addEventListener(EventAPI.Ended, cb),
    }
  }

  let queue = {
    current: ref(createTrack()),
    next: ref(createTrack()),
    timeout: ref(None),
  }

  let rec startCurrent = () => {
    queue.current.contents.start()
    queue.timeout := Some(queueNext())
    queue.current.contents.onEnded(_ => {
      queue.next := createTrack()
    })
  }
  and queueNext = () => {
    Js.Global.setTimeout(() => {
      queue.current := queue.next.contents
      startCurrent()
    }, trackLength)
  }

  let play = async () => {
    if ctx.state != Running {
      await AudioContext.resume(ctx)
    }
    startCurrent()
  }

  let stop = () => {
    switch queue.timeout.contents {
    | Some(timeoutId) => {
        Js.Global.clearTimeout(timeoutId)
        queue.timeout := None
      }
    | None => ()
    }
    queue.current.contents.stop()
    queue.current := createTrack()
  }

  (play, stop)
}

type playerState = Running | Stopped
type player = {
  armed: bool,
  state: playerState,
  play: unit => promise<unit>,
  stop: unit => unit,
}

let playerContext = React.createContext({
  armed: false,
  state: Stopped,
  play: async () => (),
  stop: () => (),
})

module InnerProvider = {
  let make = React.Context.provider(playerContext)
}

module Provider = {
  @react.component
  let make = (~children) => {
    let (armed, setArmed) = React.useState(() => false)
    let (state, setState) = React.useState(() => Stopped)
    let (play, setPlay) = React.useState(() => async () => ())
    let (stop, setStop) = React.useState(() => () => ())
    React.useEffect0(() => {
      instanciatePlayer()
      ->Promise.thenResolve(((newPlay, newStop)) => {
        setArmed(_ => true)
        setPlay(
          _ =>
            () => {
              setState(_ => Running)
              newPlay()
            },
        )
        setStop(
          _ =>
            () => {
              setState(_ => Stopped)
              newStop()
            },
        )
      })
      ->Promise.ignore
      None
    })
    let value = React.useMemo3(() => {
      {state, play, stop, armed}
    }, (state, play, stop))
    <InnerProvider value> {children} </InnerProvider>
  }
}
