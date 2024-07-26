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
  .. / .. / store / mod[
    center_modal,
    text_input,
    email_input,
    password_input,
  ],
)

#' Edit user field modal UI
#'
#' @param ns Module namespace from which this function is called.
#' @param field String. The field to edit. Either "name" (default),
#' "email" or "password".
#' @param text String. Current text value of the field. Defaults
#' to `NULL`.
#' @return [shiny::modalDialog()]
#' @export
edit_field_modal <- \(
  ns,
  field = c("name", "email", "password"),
  text = NULL
) {
  field <- match.arg(arg = field)
  prev_id <- paste0("prev_", field)
  new_id <- paste0("new_", field)
  label <- paste("New", field)
  modal_title <- paste("Edit", field)

  inputs <- switch(
    EXPR = field,
    password = tagList(
      password_input(
        ns = ns,
        input_id = prev_id,
        label = "Current password"
      ),
      password_input(
        ns = ns,
        input_id = new_id,
        label = label
      )
    ),
    email = email_input(
      inputId = ns(new_id),
      label = label,
      value = text,
      width = "100%"
    ),
    name = text_input(
      inputId = ns(new_id),
      label = label,
      value = text,
      width = "100%"
    )
  )

  btns <- tags$div(
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

  modalDialog(
    title = modal_title,
    footer = NULL,
    size = "m",
    easyClose = TRUE,
    inputs,
    btns
  ) |>
    center_modal()
}

#' Delete account modal UI
#'
#' @param ns Module namespace from which this function is called.
#' @return [shiny::modalDialog()]
#' @export
delete_account_modal <- \(ns) {
  btns <- tags$div(
    class = "d-flex justify-content-between",
    actionButton(
      inputId = ns("cancel_deletion"),
      label = "Cancel"
    ),
    actionButton(
      inputId = ns("confirm_deletion"),
      label = "Confirm"
    )
  )

  modalDialog(
    title = "Confirm account deletion",
    footer = NULL,
    size = "m",
    easyClose = TRUE,
    tags$p("Are you sure you want to delete your account?"),
    btns
  ) |>
    center_modal()
}

#' View account details UI
#'
#' @param ns Module namespace from which this function is called.
#' @return [htmltools::tags$div()]
#' @export
view_account_ui <- \(ns) {
  tags$div(
    tags$h3("Edit account details"),
    reactableOutput(outputId = ns("account_details")),
    tags$div(
      id = ns("btn_container"),
      class = "d-none justify-content-between",
      actionButton(
        inputId = ns("edit"),
        label = "Edit"
      )
    ),
    tags$h3("Delete account"),
    actionButton(
      inputId = ns("delete"),
      label = "Delete"
    ),
    tags$hr(),
    actionButton(
      inputId = ns("go_back_to_dashboard"),
      label = "Go back"
    )
  )
}

#' Account UI module
#'
#' @param id String. Module id.
#' @return [htmltools::tagList()]
#' @export
ui <- \(id) {
  ns <- NS(id)

  tagList(
    view_account_ui(ns = ns)
  )
}
