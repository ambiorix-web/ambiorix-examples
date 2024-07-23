box::use(
  shiny[
    moduleServer,
    observeEvent,
    updateTabsetPanel,
    freezeReactiveValue,
  ],
  . / login_server[login_server = server],
  . / signup_server[signup_server = server],
)

#' Auth module server
#'
#' @param id String. Module id.
#' @export
server <- \(id) {
  moduleServer(
    id = id,
    module = \(input, output, session) {
      switch_to_tab <- \(tab) {
        freezeReactiveValue(x = input, name = "tabs")
        updateTabsetPanel(
          session = session,
          inputId = "tabs",
          selected = tab
        )
      }

      r_signup <- signup_server(id = "signup")
      r_login <- login_server(id = "login")

      observeEvent(r_signup()$go_to_login, switch_to_tab("login"))
      observeEvent(r_login()$go_to_signup, switch_to_tab("signup"))
    }
  )
}
