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

type player = {
  play: unit => promise<unit>,
  stop: unit => unit,
}

let instanciatePlayer = async () => {
  let trackLength = 292571
  // let trackLength = 71000

  let res = await Fetch.fetch(soundtrack)
  let ab = await Fetch.Response.arrayBuffer(res)
  let ctx = AudioContext.make()
  let buffer = await BaseAudioContext.decodeAudioData(ctx, ab)

  let dest = BaseAudioContext.getDestination(ctx)

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
    let _ = AudioNode.connectNode(gain, dest)
    let _ = AudioNode.connectNode(bsn, gain)
    AudioScheduledSourceNode.onEnded(bsn, _ => {
      AudioNode.disconnectNode(gain, dest)
      AudioNode.disconnectNode(bsn, gain)
    })
    {
      start: () => {
        AudioScheduledSourceNode.start(bsn)
      },
      stop: () => {
        let stopTime = BaseAudioContext.getCurrentTime(ctx) +. 0.05
        let _ = AudioParam.linearRampToValueAtTime(GainNode.getGain(gain), 0.0, stopTime)
        AudioScheduledSourceNode.stop(bsn, ~when_=stopTime)
      },
      onEnded: cb => AudioScheduledSourceNode.onEnded(bsn, cb),
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
    if BaseAudioContext.getState(ctx) != #running {
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

  {play, stop}
}

let playerContext = React.createContext({
  play: async () => (),
  stop: () => (),
})

module InnerProvider = {
  let make = React.Context.provider(playerContext)
}

module Provider = {
  @react.component
  let make = (~children) => {
    let (value, setValue) = React.useState(() => {
      play: async () => (),
      stop: () => (),
    })
    React.useEffect0(() => {
      instanciatePlayer()
      ->Promise.thenResolve(player => setValue(_ => player))
      ->Promise.done
      None
    })
    <InnerProvider value> {children} </InnerProvider>
  }
}
