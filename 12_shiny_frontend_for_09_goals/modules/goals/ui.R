box::use(
  shiny[
    NS,
    uiOutput,
    textInput,
    actionButton,
  ],
  htmltools[tags],
  reactable[reactableOutput],
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
      textInput(
        inputId = ns("new_goal"),
        label = NULL,
        placeholder = "Enter goal here",
        width = "100%"
      ),
      actionButton(
        inputId = ns("create"),
        label = "Create"
      )
    ),
    tags$div(
      reactableOutput(outputId = ns("goals")),
      tags$div(
        id = ns("btn_container"),
        class = "d-none justify-content-between",
        actionButton(
          inputId = ns("edit"),
          label = "Edit"
        ),
        actionButton(
          inputId = ns("delete"),
          label = "Delete"
        )
      )
    )
  )
}
