@module external styles: {..} = "./Header.module.css"

module HeaderButton = {
  @react.component
  let make = (~onClick, ~children) => {
    <button type_="button" className={styles["button"]} onClick> {children} </button>
  }
}

module VolumeSwitch = {
  @react.component
  let make = () => {
    let {play, stop} = React.useContext(Player.playerContext)
    let (isPlaying, setIsPlaying) = React.useState(() => false)
    let toggle = () =>
      setIsPlaying(current => {
        if current {
          stop()
        } else {
          ignore(play())
        }
        !current
      })
    <HeaderButton onClick={_ => toggle()}>
      {if isPlaying {
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
