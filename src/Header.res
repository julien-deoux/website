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
    let (isPlaying, setIsPlaying) = React.useState(() => false)
    <HeaderButton onClick={_ => setIsPlaying(current => !current)}>
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
