open WebAudio

%%raw(`import soundtrack from './soundtrack.mp3';`)
@val external soundtrack: string = "soundtrack"

let trackLength = 292571
// let trackLength = 71000

let res = await Fetch.fetch(soundtrack)
let ab = await Fetch.Response.arrayBuffer(res)
let ctx = AudioContext.make()
let buffer = await BaseAudioContext.decodeAudioData(ctx, ab)

let dest = BaseAudioContext.getDestination(ctx)

type track = {
  start: unit => unit,
  stop: unit => unit,
  onEnded: (Dom.event => unit) => unit,
}

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

type queue = {
  current: ref<track>,
  next: ref<track>,
  timeout: ref<option<timeoutId>>,
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
  | Some(timeoutId) => clearTimeout(timeoutId)
  | None => ()
  }
  queue.current.contents.stop()
}

type player = {
  play: unit => promise<unit>,
  stop: unit => unit,
}

let playerContext = React.createContext({play, stop})
