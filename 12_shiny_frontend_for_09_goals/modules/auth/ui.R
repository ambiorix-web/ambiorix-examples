box::use(
  shiny[
    NS,
    tabsetPanel,
    tabPanelBody,
  ],
  htmltools[tags],
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
      tags$h3("Login page")
    ),
    tabPanelBody(
      value = "signup",
      signup_ui(id = "signup")
    )
  )
}
