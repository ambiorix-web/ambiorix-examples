box::use(
  shiny[NS],
  . / signup_ui[create_auth_page],
)

#' Login UI module
#'
#' @param id String. Module id.
#' @export
ui <- \(id) {
  ns <- NS(id)
  create_auth_page(ns = ns, type = "login")
}
