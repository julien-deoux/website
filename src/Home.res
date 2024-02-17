@module external styles: {..} = "./Home.module.css"

@react.component
let make = () =>
  <div className={styles["hero"]}>
    <div className={styles["avatar"]}>
      <div className={styles["gradients"]} />
    </div>
    <div className={styles["copy"]}>
      <div className={styles["greetings"]}>
        {React.string("Hi! I am ")}
        <strong> {React.string("Julien Déoux")} </strong>
        {React.string(",")}
      </div>
      <div className={styles["description"]}>
        {React.string("I write ")}
        <em> {React.string("music")} </em>
        {React.string(" and ")}
        <em> {React.string("software")} </em>
        {React.string(".")}
      </div>
    </div>
  </div>
