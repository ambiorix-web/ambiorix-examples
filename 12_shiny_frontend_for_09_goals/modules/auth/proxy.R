box::use(
  httr2[
    request,
    req_method,
    req_perform,
    req_url_path,
    last_response,
    resp_body_json,
    req_body_multipart,
    req_auth_bearer_token,
  ],
  .. / .. / helpers / mod[get_base_url],
  .. / .. / store / mod[toast_nofitication],
)

#' Create user account
#'
#' @param name String. Name of user.
#' @param email String. User email.
#' @param password String. Password.
#' @export
create_account <- \(name, email, password) {
  user_details <- list(
    name = name,
    email = email,
    password = password
  )

  request(base_url = get_base_url()) |>
    req_url_path("/api/users") |>
    req_body_multipart(!!!user_details) |>
    req_perform() |>
    resp_body_json()
}

#' Request error handler
#'
#' @param e Error object. See [stop()].
#' @export
req_error_handler <- \(e) {
  error <- last_response() |> resp_body_json()
  print(error)
  toast_nofitication(
    title = "Error!",
    message = error$msg,
    type = "error"
  )
}
