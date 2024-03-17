@module external styles: {..} = "./Header.module.css"

module HeaderButton = {
  @react.component
  let make = (~onClick, ~children, ~disabled=false) => {
    <button type_="button" className={styles["button"]} onClick disabled> {children} </button>
  }
}

module VolumeSwitch = {
  @react.component
  let make = () => {
    let {play, stop, state, armed} = React.useContext(Player.playerContext)
    let toggle = () =>
      if state == Running {
        stop()
      } else {
        ignore(play())
      }
    <HeaderButton onClick={_ => toggle()} disabled={!armed}>
      {if state == Running {
        <VolumeHigh />
      } else {
        <VolumeXmark />
      }}
    </HeaderButton>
  }
}

@react.component
let make = (~className="") =>
  <div className={`${styles["header"]} ${className}`}>
    <div className={styles["left"]}>
      <Anchor className={styles["homelink"]} href="/">
        <Logo className={styles["logo"]} />
      </Anchor>
    </div>
    <div className={styles["center"]}>
      <Nav className={styles["nav"]} />
    </div>
    <div className={styles["right"]}>
      <VolumeSwitch />
    </div>
  </div>
