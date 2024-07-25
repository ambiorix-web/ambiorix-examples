box::use(
  shiny[
    req,
    renderUI,
    reactiveVal,
    is.reactive,
    observeEvent,
    moduleServer,
  ],
  cli[cli_abort],
  htmltools[tags],
  . / proxy[
    create_goal,
    read_goals,
    update_goal,
    delete_goal,
  ],
  .. / auth / mod[req_error_handler],
  .. / .. / store / mod[toast_nofitication],
)

#' Goals server module
#'
#' @param id String. Module id.
#' @param rv_user [shiny::reactiveVal()]. User details after auth.
#' @export
server <- \(id, rv_user) {
  if (!is.reactive(rv_user)) {
    cls <- class(rv_user)
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
      output$username <- renderUI({
        tags$p(rv_user()$name)
      })

      observeEvent(input$create, {
        goal <- input$new_goal
        req(goal)

        tryCatch(
          expr = {
            details <- create_goal(text = goal, token = rv_user()$token)

            toast_nofitication(
              message = "New goal created!",
              type = "success"
            )
          },
          error = req_error_handler
        )
      })

      output$goals <- renderUI({
        tags$p("Goals will appear here")
      })
    }
  )
}
