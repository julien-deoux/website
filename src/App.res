@module external styles: {..} = "./App.module.css"
%%raw(`import bwavatar from './bwavatar.png';`)
@val external bwavatar: string = "bwavatar"

@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  <div className={styles["viewport"]}>
    <Header className={styles["header"]} />
    <main className={styles["main"]}>
      {switch url.path {
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
