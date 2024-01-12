box::use(
  ambiorix[parse_multipart],
  htmltools[tags],
  .. / store / contact[email_input]
)

#' Validate contact email
#'
#' Handler for POST requests at "/contact/email".
#'
#' @return An object of class `shiny.tag`
#' @export
validate_email <- \(req, res) {
  body <- parse_multipart(req)
  email <- body$email
  html <- check_valid_email(email)
  res$send(html)
}

#' Check valid email
#'
#' @return An object of class `shiny.tag`
#' @export
check_valid_email <- \(email) {
  is_valid <- is_valid_email(email)

  email_input(
    value = email,
    input_class = if (is_valid) "is-valid" else "is-invalid",
    if (!is_valid) {
      tags$div(
        class = "invalid-feedback",
        "Please enter a valid email address"
      )
    }
  )
}

#' Check if email is valid
#'
#' @param email Character vector. Emails to check.
#' @return Logical vector of same length as `email`.
#' `TRUE` if email is valid, `FALSE` otherwise.
#' @examples
#' mails <- c("example@gmail.com", "this", "S.N@org-nz.com")
#' is_valid_email(mails)
#' @export
is_valid_email <- \(email) {
  grepl(
    pattern = "\\<[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\>",
    x = email,
    ignore.case = TRUE
  )
}
