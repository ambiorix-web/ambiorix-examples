box::use(
  . / proxy[
    login,
    req_error_handler,
  ],
  shiny[
    req,
    reactive,
    reactiveVal,
    moduleServer,
    observeEvent,
  ],
  cookies[set_cookie],
  .. / .. / store / mod[toast_nofitication],
)

#' Login server module
#'
#' @param id String. Module id.
#' @export
server <- \(id) {
  moduleServer(
    id = id,
    module = \(input, output, session) {
      rv_user <- reactiveVal()

      observeEvent(input$login, {
        email <- input$email
        password <- input$password
        req(email, password)

        tryCatch(
          expr = {
            details <- login(
              email = email,
              password = password
            )
            rv_user(details$user)

            toast_nofitication(
              message = "Logged in!",
              type = "success"
            )
          },
          error = req_error_handler
        )
      })

      # on login, set auth cookie:
      observeEvent(rv_user(), {
        set_cookie(
          cookie_name = "auth",
          cookie_value = rv_user()$token,
          secure_only = TRUE,
          expiration = 30L
        )
      })

      r_res <- reactive({
        list(
          go_to_signup = input$signup,
          user = rv_user()
        )
      })
      return(r_res)
    }
  )
}
