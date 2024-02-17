type player = {
  play: unit => promise<unit>,
  stop: unit => unit,
}

let playerContext: React.Context.t<player>
