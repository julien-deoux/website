@react.component
let make = (~href, ~className, ~children) => {
  let onClick = e => {
    if !ReactEvent.Mouse.ctrlKey(e) && !ReactEvent.Mouse.metaKey(e) {
      ReactEvent.Mouse.preventDefault(e)
      RescriptReactRouter.push(href)
    }
  }
  <a className onClick href> {children} </a>
}
