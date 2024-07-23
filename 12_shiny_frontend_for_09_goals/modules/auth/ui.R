box::use(
  shiny[
    NS,
    tabsetPanel,
    tabPanelBody,
  ],
  htmltools[tags],
  . / login_ui[login_ui = ui],
  . / signup_ui[signup_ui = ui],
)

#' Auth module UI
#'
#' @param id String. Module id.
#' @export
ui <- \(id) {
  ns <- NS(id)

  tabsetPanel(
    id = ns("tabs"),
    type = "hidden",
    selected = "signup",
    tabPanelBody(
      value = "login",
      login_ui(id = ns("login"))
    ),
    tabPanelBody(
      value = "signup",
      signup_ui(id = ns("signup"))
    )
  )
}
