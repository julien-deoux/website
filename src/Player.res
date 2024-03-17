open WebAudio

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

  let res = await Fetch.fetch(soundtrack)
  let ab = await Fetch.Response.arrayBuffer(res)
  let ctx = AudioContext.make()
  let buffer = await AudioContext.decodeAudioData(ctx, ab)

  let dest = AudioContext.getDestination(ctx)

  let createTrack = () => {
    let bsn = AudioBufferSourceNode.make(
      ctx,
      ~options={
        buffer: buffer,
      },
    )
    let gain = GainNode.make(
      ctx,
      ~options={
        gain: 0.3,
      },
    )
    let _ = GainNode.connectNode(gain, dest)
    let _ = AudioBufferSourceNode.connectNode(bsn, gain)
    AudioBufferSourceNode.onEnded(bsn, _ => {
      GainNode.disconnectNode(gain, dest)
      AudioBufferSourceNode.disconnectNode(bsn, gain)
    })
    {
      start: () => {
        AudioBufferSourceNode.start(bsn)
      },
      stop: () => {
        let stopTime = AudioContext.getCurrentTime(ctx) +. 0.05
        let _ = AudioParam.linearRampToValueAtTime(GainNode.getGain(gain), 0.0, stopTime)
        AudioBufferSourceNode.stop(bsn, ~when_=stopTime)
      },
      onEnded: cb => AudioBufferSourceNode.onEnded(bsn, cb),
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
    setTimeout(() => {
      queue.current := queue.next.contents
      startCurrent()
    }, trackLength)
  }

  let play = async () => {
    if AudioContext.getState(ctx) != #running {
      await AudioContext.resume(ctx)
    }
    startCurrent()
  }

  let stop = () => {
    switch queue.timeout.contents {
    | Some(timeoutId) => {
        clearTimeout(timeoutId)
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
          _ => () => {
            setState(_ => Running)
            newPlay()
          },
        )
        setStop(
          _ => () => {
            setState(_ => Stopped)
            newStop()
          },
        )
      })
      ->Promise.done
      None
    })
    let value = React.useMemo3(() => {
      {state, play, stop, armed}
    }, (state, play, stop))
    <InnerProvider value> {children} </InnerProvider>
  }
}
