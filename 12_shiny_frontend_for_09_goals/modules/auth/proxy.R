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
#' @return Named list.
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

#' Login user
#'
#' @param email String. User email.
#' @param password String. Password.
#' @return Named list.
#' @export
login <- \(email, password) {
  user_details <- list(
    email = email,
    password = password
  )

  request(base_url = get_base_url()) |>
    req_url_path("/api/users/login") |>
    req_body_multipart(!!!user_details) |>
    req_perform() |>
    resp_body_json()
}

#' Get user account details
#'
#' @param token String. JWT token.
#' @return Named list.
#' @export
get_account_details <- \(token) {
  request(base_url = get_base_url()) |>
    req_url_path("/api/users/me") |>
    req_auth_bearer_token(token = token) |>
    req_perform() |>
    resp_body_json()
}

#' Update user account details
#'
#' @param name String. Name of user.
#' @param email String. User email.
#' @param password String. Password.
#' @param token String. JWT token.
#' @return Named list.
#' @export
update_account_details <- \(
  name = NULL,
  email = NULL,
  password = NULL,
  token
) {
  new_details <- list(
    name = name,
    email = email,
    password = password
  )

  request(base_url = get_base_url()) |>
    req_url_path("/api/users/me") |>
    req_auth_bearer_token(token = token) |>
    req_method(method = "PUT") |>
    req_body_multipart(!!!new_details) |>
    req_perform() |>
    resp_body_json()
}

#' Delete user account
#'
#' @param token String. JWT token.
#' @return Named list.
#' @export
delete_account <- \(token) {
  request(base_url = get_base_url()) |>
    req_url_path("/api/users/me") |>
    req_auth_bearer_token(token = token) |>
    req_method(method = "DELETE") |>
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
