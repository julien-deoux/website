@react.component
let make = (~href, ~className, ~children) => {
  let onClick = e => {
    ReactEvent.Mouse.preventDefault(e)
    RescriptReactRouter.push(href)
  }
  <a className onClick href> {children} </a>
}
