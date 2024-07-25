box::use(
  data.table[
    rbindlist,
  ],
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
  reactable[
    colDef,
    reactable,
    renderReactable,
    getReactableState,
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
      fetch_goals <- \(token = rv_user()$token) {
        goals <- read_goals(token = rv_user()$token)
        rbindlist(l = goals$goals, use.names = TRUE)
      }

      rv_goals <- reactiveVal()

      observeEvent(rv_user(), rv_goals(fetch_goals()))

      output$username <- renderUI({
        tags$p(rv_user()$name)
      })

      observeEvent(input$create, {
        goal <- input$new_goal
        req(goal)

        tryCatch(
          expr = {
            details <- create_goal(text = goal, token = rv_user()$token)
            rv_goals(fetch_goals())

            toast_nofitication(
              message = "New goal created!",
              type = "success"
            )
          },
          error = req_error_handler
        )
      })

      output$goals <- renderReactable({
        data <- rv_goals()
        height <- if (nrow(data) >= 15) 600 else "auto"
        columns <- list(
          `_id` = colDef(show = FALSE),
          text = colDef(name = "Goals")
        )

        reactable(
          data = data,
          wrap = FALSE,
          highlight = TRUE,
          bordered = TRUE,
          resizable = TRUE,
          pagination = FALSE,
          onClick = "select",
          selection = "single",
          height = height,
          columns = columns
        )
      })

      observeEvent(
        eventExpr = getReactableState(
          outputId = "goals",
          name = "selected"
        ),
        handlerExpr = {
          selected_row <- getReactableState(
            outputId = "goals",
            name = "selected"
          )
          print(selected_row)
        }
      )
    }
  )
}
