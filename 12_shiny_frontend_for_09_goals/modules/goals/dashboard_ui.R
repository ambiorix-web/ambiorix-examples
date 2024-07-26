box::use(
  shiny[
    NS,
    uiOutput,
    textInput,
    modalDialog,
    actionButton,
  ],
  htmltools[tags],
  reactable[reactableOutput],
  .. / .. / store / mod[
    text_input,
    center_modal,
  ],
)

#' Create new goal UI
#'
#' @param ns Module namespace from which this function is called.
#' @return [htmltools::tags$div()]
#' @export
new_goal_ui <- \(ns) {
  tags$form(
    id = ns("new_goal_form"),
    tags$div(
      class = "d-flex",
      text_input(
        inputId = ns("new_goal"),
        label = NULL,
        placeholder = "Enter goal here"
      ),
      actionButton(
        inputId = ns("create"),
        class = "ms-1 mb-3",
        label = "Create",
        type = "submit"
      )
    )
  )
}

#' Edit goal modal UI
#'
#' @param ns Module namespace from which this function is called.
#' @param text String. Current text value of goal.
#' @return [shiny::modalDialog()]
#' @export
edit_goal_modal <- \(ns, text) {
  modalDialog(
    title = "Edit goal",
    footer = NULL,
    size = "m",
    easyClose = TRUE,
    textInput(
      inputId = ns("edited_goal"),
      label = NULL,
      value = text,
      width = "100%"
    ),
    tags$div(
      class = "d-flex justify-content-between",
      actionButton(
        inputId = ns("cancel_edit"),
        label = "Cancel"
      ),
      actionButton(
        inputId = ns("confirm_edit"),
        label = "Save"
      )
    )
  ) |>
    center_modal()
}

#' View goals UI
#'
#' @param ns Module namespace from which this function is called.
#' @return [htmltools::tags$div()]
#' @export
view_goals_ui <- \(ns) {
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
}

#' Dashboard UI module
#'
#' @param id String. Module id.
#' @return [htmltools::tags$div()]
#' @export
ui <- \(id) {
  ns <- NS(id)

  tags$div(
    new_goal_ui(ns = ns),
    view_goals_ui(ns = ns)
  )
}
