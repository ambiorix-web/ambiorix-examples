box::use(
  htmltools[tags, tagList],
  . / nav[nav],
  . / create_card[create_card]
)

#' The "About" page
#'
#' @return An object of class `shiny.tag`
#' @export
about <- \() {
  tagList(
    nav(active = "About"),
    tags$div(
      class = "container",
      create_card(
        title = "About Us",
        title_icon = tags$i(class = "bi bi-info-circle"),
        title_class = "text-primary",
        class = "shadow-sm",
        tags$p("Here are a few things you might want to know:"),
        tags$ul(
          tags$li("Ambiorix is an unopinionated framework"),
          tags$li("It doesn't care about what you decide to use for your frontend"),
          tags$li("Ambiorix works great with htmx, btw.")
        )
      )
    )
  )
}
