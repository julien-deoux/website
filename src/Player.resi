type player = {
  play: unit => promise<unit>,
  stop: unit => unit,
}

let playerContext: React.Context.t<player>

module Provider: {
  @react.component
  let make: (~children: React.element) => React.element
}
