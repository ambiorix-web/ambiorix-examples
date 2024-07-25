#' @export
box::use(
  . / ui[auth_ui = ui],
  . / proxy[
    req_error_handler,
    get_account_details,
  ],
  . / server[auth_server = server],
)
