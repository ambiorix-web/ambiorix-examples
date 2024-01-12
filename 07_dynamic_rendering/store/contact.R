box::use(
  htmltools[tags, tagList],
  . / nav[nav],
  . / create_card[create_card]
)

#' The "Contact" page
#'
#' @return An object of class `shiny.tag`
#' @export
contact <- \() {
  tagList(
    nav(active = "Contact"),
    tags$div(
      class = "container",
      create_card(
        title = "Talk to us",
        title_icon = tags$i(class = "bi bi-chat-dots"),
        title_class = "text-primary",
        class = "shadow-sm",
        tags$p(
          "Let us know what you think by sending us a message below"
        )
      ),
      create_card(
        class = "my-3 shadow-sm",
        contact_form()
      )
    )
  )
}

#' Contact form
#'
#' @export
contact_form <- \() {
  tags$form(
    `hx-target` = "this",
    `hx-post` = "/contact",
    `hx-swap` = "outerHTML",
    email_input(),
    tags$div(
      class = "row",
      tags$div(
        class = "col-12 col-md-6",
        name_input(kind = "First")
      ),
      tags$div(
        class = "col-12 col-md-6",
        name_input(kind = "Last")
      )
    ),
    text_area_input(),
    submit_btn()
  )
}

#' Contact email input
#'
#' @param value Value of the input
#' @param ... tags to append to end of div
#' @param input_class Additional bootstrap classes for the input. Mostly used
#' for validation.
#' @return An object of class `shiny.tag`
#' @export
email_input <- \(..., value = "", input_class = NULL) {
  tags$div(
    class = "mb-3",
    `hx-target` = "this",
    `hx-swap` = "outerHTML",
    tags$label(
      `for` = "email",
      class = "form-label",
      "Email address"
    ),
    tags$input(
      type = "email",
      name = "email",
      id = "email",
      class = paste("form-control", input_class),
      required = NA,
      value = value,
      `hx-post` = "/contact/email"
    ),
    ...
  )
}

#' Name input
#'
#' @param kind String. Kind of name. Either "First", "Middle", or "Last".
#' @param value String. Value of the input.
#' @return An object of class `shiny.tag`
#' @export
name_input <- \(kind = "First", value = "") {
  id <- paste0(kind, "name")
  tags$div(
    class = "mb-3",
    tags$label(
      `for` = id,
      class = "form-label",
      paste(kind, "name")
    ),
    tags$input(
      type = "text",
      name = id,
      id = id,
      class = "form-control",
      value = value
    )
  )
}

#' Text area input
#'
#' @param ... tags to append to end of div
#' @param id Input id
#' @param label Input label
#' @param value Input value
#' @param input_class Additional bootstrap classes for the input. Mostly used
#' for validation.
#' @export
text_area_input <- \(
  ...,
  id = "msg",
  label = "Your message",
  value = "",
  input_class = NULL
) {
  tags$div(
    class = "mb-3",
    `hx-target` = "this",
    `hx-swap` = "outerHTML",
    tags$label(
      `for` = id,
      class = "form-label",
      label
    ),
    tags$textarea(
      class = paste("form-control", input_class),
      id = id,
      name = id,
      rows = "3",
      required = NA,
      `hx-post` = "/contact/message",
      value
    ),
    ...
  )
}

#' Submit button
#'
#' @param class Button class
#' @return An object of class `shiny.tag`
#' @export
submit_btn <- \(class = "btn btn-primary px-4 rounded-1") {
  tags$button(
    type = "submit",
    class = class,
    "Submit"
  )
}
