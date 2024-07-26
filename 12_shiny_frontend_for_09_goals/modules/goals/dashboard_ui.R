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

#' Goal modal UI
#'
#' Can be used as both the edit or delete goal modal.
#' @param ns Module namespace from which this function is called.
#' @param type String. Type of modal. Either "edit" (default) or "delete".
#' @param text String. Current text value of goal. Defaults to `NULL`.
#' @return [shiny::modalDialog()]
#' @export
goal_modal <- \(
  ns,
  type = c("edit", "delete"),
  text = NULL
) {
  type <- match.arg(arg = type)
  is_edit <- identical(type, "edit")
  cancel_id <- paste0("cancel_", type)
  confirm_id <- paste0("confirm_", type)
  confirm_label <- if (is_edit) "Save" else "Confirm"
  title <- paste(
    if (is_edit) "Edit" else "Delete",
    "goal"
  )

  modalDialog(
    title = NULL,
    footer = NULL,
    size = "m",
    easyClose = TRUE,
    tags$h5(
      class = "mb-3",
      title
    ),
    if (is_edit) {
      textInput(
        inputId = ns("edited_goal"),
        label = NULL,
        value = text,
        width = "100%"
      )
    },
    tags$div(
      class = "d-flex justify-content-between",
      actionButton(
        inputId = ns(cancel_id),
        label = "Cancel"
      ),
      actionButton(
        inputId = ns(confirm_id),
        label = confirm_label
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
      class = "d-none justify-content-between my-2",
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
