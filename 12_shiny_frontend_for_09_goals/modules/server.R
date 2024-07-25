box::use(
  shiny[
    req,
    isTruthy,
    reactiveVal,
    observeEvent,
    updateTabsetPanel,
    freezeReactiveValue,
  ],
  cookies[get_cookie],
  . / auth / mod[
    auth_server,
    get_account_details,
  ],
  . / goals / mod[goals_server],
  .. / store / mod[toast_nofitication],
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

  rv_user <- reactiveVal()
  r_user <- auth_server(id = "auth")
  r_goals <- goals_server(id = "goals", rv_user = rv_user)

  observeEvent(r_user(), {
    rv_user(r_user())
    switch_to_tab("goals")
  })

  observeEvent(
    eventExpr = get_cookie(cookie_name = "auth"),
    handlerExpr = {
      token <- get_cookie(cookie_name = "auth")
      req(token)

      # if it's signup or login, no need to get user details:
      is_signup_or_login <- isTruthy(rv_user()$token)
      if (is_signup_or_login) {
        return()
      }

      tryCatch(
        expr = {
          details <- get_account_details(token = token)
          details$user$token <- token

          rv_user(details$user)
          switch_to_tab("goals")
          toast_nofitication(
            message = "Logged in!",
            type = "success"
          )
        },
        error = \(e) {
          "Invalid token, not signing in"
        }
      )
    }
  )
}
