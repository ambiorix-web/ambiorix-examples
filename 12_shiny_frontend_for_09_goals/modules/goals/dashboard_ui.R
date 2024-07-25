box::use(
  shiny[
    NS,
    tagList,
    uiOutput,
    textInput,
    modalDialog,
    actionButton,
  ],
  htmltools[tags],
  reactable[reactableOutput],
  .. / .. / store / mod[center_modal],
)

#' Create new goal UI
#'
#' @param ns Module namespace from which this function is called.
#' @return [htmltools::tags$div()]
#' @export
new_goal_ui <- \(ns) {
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
#' @return [htmltools::tagList()]
#' @export
ui <- \(id) {
  ns <- NS(id)

  tagList(
    new_goal_ui(ns = ns),
    view_goals_ui(ns = ns)
  )
}
