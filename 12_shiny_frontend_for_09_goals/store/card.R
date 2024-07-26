box::use(
  htmltools[tags],
)

#' Create a bootstrap card
#'
#' @param ... [htmltools::tags] Card content.
#' @param class Character vector. Classes to apply to the card body.
#' @return [htlmtools::tags$div()]
#' @export
card <- \(..., class = NULL) {
  class <- c("card-body", class)

  tags$div(
    class = "card border-2 border-light",
    tags$div(
      class = class,
      ...
    )
  )
}
