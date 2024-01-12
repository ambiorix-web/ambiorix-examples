box::use(
  ambiorix[parse_multipart],
  htmltools[tags],
  shiny[isTruthy],
  . / validate_email[is_valid_email, check_valid_email],
  . / validate_message[check_valid_message],
  .. / store / contact
)

#' Receive message sent by user
#'
#' Handler for POST requests at "/contact"
#'
#' @return An object of class `shiny.tag`
#' @export
contact_post <- \(req, res) {
  body <- parse_multipart(req)
  email <- body$email
  firstname <- body$Firstname
  lastname <- body$Lastname
  message <- body$msg

  all_valid <- is_valid_email(email) &&
    isTruthy(message)

  if (all_valid) {
    html <- tags$p(
      class = "text-success",
      "Thank you! We shall happily review your feedback."
    )
    return(res$send(html))
  }

  email_input <- check_valid_email(email)
  message_input <- check_valid_message(message)

  html <- tags$form(
    `hx-target` = "this",
    `hx-post` = "/contact",
    `hx-swap` = "outerHTML",
    email_input,
    tags$div(
      class = "row",
      tags$div(
        class = "col-12 col-md-6",
        contact$name_input(kind = "First", value = firstname)
      ),
      tags$div(
        class = "col-12 col-md-6",
        contact$name_input(kind = "Last", value = lastname)
      )
    ),
    message_input,
    contact$submit_btn()
  )
  res$send(html)
}
