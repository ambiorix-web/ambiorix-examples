box::use(
  shiny[
    icon,
    textInput,
    passwordInput,
    actionButton
  ],
  htmltools[
    tags,
    tagList,
    tagQuery,
  ]
)

#' Text input
#'
#' @param ... Named arguments passed to [shiny::textInput()]
#' @param required Logical. Whether to add the html attribute 'required' to the
#' input.
#' @return [htmltools::tags()]
#' @export
text_input <- \(..., required = TRUE) {
  required <- if (required) NA

  tag_q <- textInput(..., width = "100%") |> tagQuery()
  tag_q$
    find("input")$
    addAttrs(required = required)$
    allTags()
}

#' Email input
#'
#' @param ... Named arguments passed to [shiny::textInput()]
#' @param required Logical. Whether to add the html attribute 'required' to the
#' input.
#' @return [htmltools::tags()]
#' @export
email_input <- \(..., required = TRUE) {
  required <- if (required) NA

  tag_q <- textInput(..., width = "100%") |> tagQuery()
  tag_q$
    find("input")$
    removeAttrs("type")$
    addAttrs(type = "email", required = required)$
    allTags()
}

#' Password input
#'
#' @param ns Module namespace from which this function is called.
#' @param input_id String. Input id of the password. Don't wrap in `ns()`.
#' Defaults to "password".
#' @param label String, [htmltools::tags()]. Label of the input. Defaults to
#' "Password".
#' @param required Logical. Whether to add the html attribute 'required' to the
#' input.
#' @return [htmltools::tags()]
#' @export
password_input <- \(
  ns,
  input_id = "password",
  label = "Password",
  required = TRUE
) {
  required <- if (required) NA
  input_id <- ns(input_id)

  btn_id <- sprintf("toggle_%s", input_id) |> ns()
  btn <- actionButton(
    inputId = btn_id,
    label = NULL,
    icon = icon(name = "eye")
  )

  toggle_password_script <- tags$script(
    sprintf(
      "toggle_password('%s', '%s')",
      input_id,
      btn_id
    )
  )

  tag_q <- passwordInput(
    inputId = input_id,
    label = label,
    width = "100%"
  ) |> tagQuery()

  tag_q$find("input")$addAttrs(required = required)
  input <- tags$div(
    class = "input-group",
    tag_q$find("input")$selectedTags(),
    btn
  )
  tag_q$find("input")$replaceWith(input)

  tagList(
    tag_q$allTags(),
    toggle_password_script
  )
}
