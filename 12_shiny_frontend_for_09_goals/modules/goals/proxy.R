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
  .. / auth / mod[req_error_handler],
  .. / .. / helpers / mod[get_base_url],
  .. / .. / store / mod[toast_nofitication],
)

#' Create a new goal
#'
#' @param text String. The goal.
#' @param token String. JWT token.
#' @return Named list.
#' @export
create_goal <- \(text, token) {
  request(base_url = get_base_url()) |>
    req_url_path("/api/goals") |>
    req_auth_bearer_token(token = token) |>
    req_body_multipart(text = text) |>
    req_perform() |>
    resp_body_json()
}

#' Read all goals
#'
#' @param token String. JWT token.
#' @return Named list.
#' @export
read_goals <- \(token) {
  request(base_url = get_base_url()) |>
    req_url_path("/api/goals") |>
    req_auth_bearer_token(token = token) |>
    req_perform() |>
    resp_body_json()
}

#' Update a goal
#'
#' @param id String. Goal id.
#' @param text String. Updated goal.
#' @param token String. JWT token.
#' @return Named list.
#' @export
update_goal <- \(
  id,
  text,
  token
) {
  path <- paste0("/api/goals/", id)
  request(base_url = get_base_url()) |>
    req_url_path(path) |>
    req_auth_bearer_token(token = token) |>
    req_method(method = "PUT") |>
    req_body_multipart(text = text) |>
    req_perform() |>
    resp_body_json()
}

#' Delete a goal
#'
#' @param id String. Goal id.
#' @param token String. JWT token.
#' @return Named list.
#' @export
delete_goal <- \(id, token) {
  path <- paste0("/api/goals/", id)
  request(base_url = base_url) |>
    req_url_path(path) |>
    req_auth_bearer_token(token = token) |>
    req_method(method = "DELETE") |>
    req_perform() |>
    resp_body_json()
}
