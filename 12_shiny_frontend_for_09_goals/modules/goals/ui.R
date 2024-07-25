box::use(
  shiny[
    NS,
    uiOutput,
  ],
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
    class = "container",
    tags$div(
      class = "d-flex justify-content-between",
      tags$h4("Goals"),
      uiOutput(outputId = ns("username"))
    ),
    tags$div(
      uiOutput(outputId = ns("goals"))
    )
  )
}
