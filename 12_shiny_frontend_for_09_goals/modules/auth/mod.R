#' @export
box::use(
  . / ui[auth_ui = ui],
  . / proxy[get_account_details],
  . / server[auth_server = server],
)
