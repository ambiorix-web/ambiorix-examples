box::use(
  shiny[
    req,
    reactive,
    isTruthy,
    reactiveVal,
    moduleServer,
    observeEvent,
  ],
  cookies[set_cookie],
  . / proxy[
    create_account,
    req_error_handler,
  ],
  .. / .. / store / mod[toast_nofitication],
)

#' Signup server module
#'
#' @param id String. Module id.
#' @export
server <- \(id) {
  moduleServer(
    id = id,
    module = \(input, output, session) {
      rv_user <- reactiveVal()

      observeEvent(input$signup, {
        name <- input$name
        email <- input$email
        password <- input$password
        req(name, email, password)

        tryCatch(
          expr = {
            details <- create_account(
              name = name,
              email = email,
              password = password
            )
            rv_user(details$user)

            toast_nofitication(
              title = "Success!",
              message = "Account created.",
              type = "success"
            )
          },
          error = req_error_handler
        )
      })

      observeEvent(rv_user(), {
        # on registration, set auth cookie:
        set_cookie(
          cookie_name = "auth",
          cookie_value = rv_user()$token,
          secure_only = TRUE,
          expiration = 30L
        )
      })

      r_res <- reactive({
        list(
          go_to_login = input$login,
          user = rv_user()
        )
      })
      return(r_res)
    }
  )
}
