@module external styles: {..} = "./App.module.css"

module RoutedApp = {
  @react.component
  let make = (~route) => {
    <div className={styles["viewport"]}>
      <Header className={styles["header"]} />
      <main className={styles["main"]}>
        {switch route {
        | list{"music", ..._} => <Construction />
        | list{"software", ..._} => <Construction />
        | list{"blog", ..._} => <Construction />
        | list{} => <Home />
        | _ => React.string("ouch")
        }}
      </main>
      <div className={styles["footer"]}>
        <Nav />
      </div>
    </div>
  }
}

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  <Player.Provider>
    <RoutedApp route=url.path />
  </Player.Provider>
}
