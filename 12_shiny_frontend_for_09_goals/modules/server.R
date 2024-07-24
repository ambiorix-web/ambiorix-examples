box::use(
  shiny[
    observeEvent,
    updateTabsetPanel,
    freezeReactiveValue,
  ],
  . / auth / mod[auth_server],
  . / goals / mod[goals_server],
)

#' App server
#'
#' @export
server <- \(input, output, session) {
  switch_to_tab <- \(tab) {
    freezeReactiveValue(x = input, name = "pages")
    updateTabsetPanel(
      session = session,
      inputId = "pages",
      selected = tab
    )
  }

  r_user <- auth_server(id = "auth")

  observeEvent(r_user(), switch_to_tab("goals"))
}
