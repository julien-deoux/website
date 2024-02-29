@module external styles: {..} = "./Construction.module.css"
let s = React.string

@react.component
let make = () => {
  <div className={styles["page"]}>
    <div>
      <h1 className={styles["title"]}> {s("This section is under construction")} </h1>
      <div className={styles["cta"]}> {s("In the meantime, checkout my socials!")} </div>
      <div className={styles["split"]}>
        <div>
          <h2 className={styles["subtitle"]}> {s("Software")} </h2>
          <ul className={styles["list"]}>
            <li>
              <a
                className={styles["link"]}
                href="https://linkedin.com/in/julien-deoux"
                target="_blank">
                {s("Linkedin")}
              </a>
            </li>
            <li>
              <a className={styles["link"]} href="https://github.com/julien-deoux" target="_blank">
                {s("Github")}
              </a>
            </li>
          </ul>
        </div>
        <div>
          <h2 className={styles["subtitle"]}> {s("Music")} </h2>
          <ul className={styles["list"]}>
            <li>
              <a
                className={styles["link"]} href="https://julien-deoux.bandcamp.com" target="_blank">
                {s("Bandcamp")}
              </a>
            </li>
            <li>
              <a
                className={styles["link"]}
                href="https://www.youtube.com/channel/UCIibZ-r7mfCqf-UfFhZ2DzQ"
                target="_blank">
                {s("Youtube")}
              </a>
            </li>
            <li>
              <a
                className={styles["link"]}
                href="https://www.instagram.com/julien.deoux"
                target="_blank">
                {s("Instagram")}
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
}
