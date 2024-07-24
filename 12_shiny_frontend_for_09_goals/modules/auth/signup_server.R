box::use(
  shiny[
    req,
    reactive,
    isTruthy,
    reactiveVal,
    moduleServer,
    observeEvent,
  ],
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
        # TODO: set auth cookie (jwt)
        print(rv_user())
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
