box::use(
  htmltools[tags, tagList],
  . / nav[nav],
  . / create_card[create_card]
)

#' The "Home" page
#'
#' @return An object of class `shiny.tag`
#' @export
home <- \() {
  tagList(
    nav(),
    tags$div(
      class = "container",
      create_card(
        title = "Hi there!",
        title_icon = tags$i(class = "bi bi-house-door"),
        title_class = "text-primary",
        class = "shadow-sm",
        tags$p("This is our homepage."),
        tags$p("ambiorix + htmx = 🚀")
      )
    )
  )
}
