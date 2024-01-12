box::use(
  htmltools[tags]
)

#' Create a custom bootstrap card
#'
#' @param title Card title
#' @param title_icon Icon to place before the title. Can be a `shiny::tags$i()`.
#' @param title_class String. Additional bootstrap classes for the title.
#' @param class Additional classes to apply to the card container
#' @param ... Card content
#' @return [shiny::tags$div]
#' @export
create_card <- \(
  ...,
  title = NULL,
  title_icon = NULL,
  title_class = NULL,
  class = NULL
) {
  tags$div(
    class = paste("card p-1 p-md-4 border-0", class),
    tags$div(
      class = "card-body",
      if (!is.null(title) || !is.null(title_icon)) {
        tags$h3(
          class = paste("card-title fw-semibold fs-4 mb-3", title_class),
          title_icon,
          title
        )
      },
      ...
    )
  )
}
