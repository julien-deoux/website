@module external styles: {..} = "./Nav.module.css"

module NavLink = {
  @react.component
  let make = (~path) => {
    let url = RescriptReactRouter.useUrl()
    let className = switch List.head(url.path) {
    | Some(x) if x == path => styles["selected"]
    | _ => ""
    }
    <li className={styles["link"]}>
      <Anchor href={`/${path}`} className> {React.string(path)} </Anchor>
    </li>
  }
}

@react.component
let make = (~className="") => {
  <nav className={`${styles["nav"]} ${className}`}>
    <ul>
      <NavLink path="music" />
      <NavLink path="software" />
      <NavLink path="blog" />
    </ul>
  </nav>
}
