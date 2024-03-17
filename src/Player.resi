type playerState = Running | Stopped
type player = {
  armed: bool,
  state: playerState,
  play: unit => promise<unit>,
  stop: unit => unit,
}

let playerContext: React.Context.t<player>

module Provider: {
  @react.component
  let make: (~children: React.element) => React.element
}
