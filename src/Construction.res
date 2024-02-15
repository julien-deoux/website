@module external styles: {..} = "./Construction.module.css"

@react.component
let make = () => {
  <div className={styles["page"]}>
    <div className={styles["title"]}> {React.string("Under construction")} </div>
    <div className={styles["subtitle"]}>
      {React.string("This section is coming soon (or never).")}
    </div>
  </div>
}
