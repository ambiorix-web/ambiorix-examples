#' @export
box::use(
  . / ui[auth_ui = ui],
  . / proxy[
    login,
    delete_account,
    req_error_handler,
    get_account_details,
    update_account_details,
  ],
  . / server[auth_server = server],
)
