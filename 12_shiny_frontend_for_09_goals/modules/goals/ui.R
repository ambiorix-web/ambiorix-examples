box::use(
  shiny[NS],
  htmltools[tags],
)

#' Goals UI module
#'
#' @param id String. Module id.
#' @return [htmltools::tags$div()]
#' @export
ui <- \(id) {
  ns <- NS(id)

  tags$div(
    tags$h3("Set goals here!")
  )
}
