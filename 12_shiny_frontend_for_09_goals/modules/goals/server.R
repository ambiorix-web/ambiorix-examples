box::use(
  cli[cli_abort],
  cookies[remove_cookie],
  shiny[
    renderUI,
    is.reactive,
    moduleServer,
    observeEvent,
    updateTabsetPanel,
    freezeReactiveValue,
  ],
  . / ui[user_profile_btn],
  . / account_server[account_server = server],
  . / dashboard_server[dashboard_server = server],
)

#' Goals server module
#'
#' @param id String. Module id.
#' @param rv_user [shiny::reactiveVal()]. User details after auth.
#' @export
server <- \(id, rv_user) {
  if (!is.reactive(rv_user)) {
    cli_abort(
      message = c(
        "x" = "{.var rv_user} must be a {.fn reactiveVal}",
        "i" = "Did you pass in a bare value instead of a reactive?"
      )
    )
  }

  moduleServer(
    id = id,
    module = \(input, output, session) {
      ns <- session$ns

      switch_to_tab <- \(tab) {
        freezeReactiveValue(x = input, name = "tabs")
        updateTabsetPanel(
          session = session,
          inputId = "tabs",
          selected = tab
        )
      }

      output$user_profile_btn <- renderUI({
        user_profile_btn(
          ns = ns,
          user_name = rv_user()$name
        )
      })

      observeEvent(input$logout, {
        # remove auth cookie, reload page:
        remove_cookie(cookie_name = "auth")
        session$reload()
      })

      observeEvent(input$go_to_account_settings, switch_to_tab("account"))

      dashboard_server(id = "dashboard", rv_user = rv_user)

      r_account <- account_server(id = "account", rv_user = rv_user)
      observeEvent(r_account()$go_back_to_dashboard, {
        switch_to_tab("dashboard")
      })
    }
  )
}
