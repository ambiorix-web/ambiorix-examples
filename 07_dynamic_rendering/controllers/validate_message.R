box::use(
  ambiorix[parse_multipart],
  htmltools[tags],
  shiny[isTruthy],
  .. / store / contact[text_area_input]
)

#' Validate message sent by user
#'
#' Handler for POST requests at "/contact/message".
#'
#' @return An object of class `shiny.tag`
#' @export
validate_message <- \(req, res) {
  body <- parse_multipart(req)
  text <- body$msg
  html <- check_valid_message(text)
  res$send(html)
}

#' Check if message sent by user is valid
#'
#' @return An object of class `shiny.tag`
#' @export
check_valid_message <- \(message) {
  is_valid <- isTruthy(message)

  text_area_input(
    value = message,
    input_class = if (is_valid) "is-valid" else "is-invalid",
    if (!is_valid) {
      tags$div(
        class = "invalid-feedback",
        "Please enter a message"
      )
    }
  )
}
