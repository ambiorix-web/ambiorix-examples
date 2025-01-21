box::use(
  htmltools[...],
)

#' @export
page <- function(...) {
  tags$html(
    tags$head(
      tags$title("Ambiorix chat"),
      tags$link(
        rel = "stylesheet",
        href = "https://unpkg.com/nes.css@2.3.0/css/nes.min.css"
      ),
      tags$link(
        rel = "stylesheet",
        href = "https://fonts.googleapis.com/css?family=Press+Start+2P"
      ),
      tags$link(
        rel = "stylesheet",
        href = "static/style.css"
      ),
      tags$script(
        src = "static/ambiorix.js"
      ),
      tags$script(
        src = "static/chat.js",
        defer = NA
      )
    ),
    tags$body(
      class = "container",
      h1("R chat app"),
      tags$section(
        class = "nes-container mb-1",
        id = "chat",
        tags$section(
          class = "message-list",
          id = "chat-list"
        )
      ),
      div(
        class = "d-flex",
        div(
          class = "d-grow",
          div(
            class = "nes-field mr-1",
            tags$input(
              id = "message",
              class = "nes-input",
              placeholder = "Your message"
            )
          )
        ),
        div(
          class = "d-shrink",
          tags$button(
            id = "send",
            type = "button",
            class = "nes-btn is-primary",
            "SEND"
          )
        )
      ),
      ...
    )
  )
}
