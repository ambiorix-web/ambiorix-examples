box::use(
  cli[cli_abort],
  shinyjs[
    reset,
    toggleClass,
  ],
  shiny[
    req,
    isTruthy,
    showModal,
    reactiveVal,
    removeModal,
    is.reactive,
    observeEvent,
    moduleServer,
  ],
  data.table[
    rbindlist,
    data.table,
  ],
  reactable[
    colDef,
    reactable,
    reactableLang,
    renderReactable,
    getReactableState,
  ],
  . / proxy[
    create_goal,
    read_goals,
    update_goal,
    delete_goal,
  ],
  . / dashboard_ui[edit_goal_modal],
  .. / auth / mod[req_error_handler],
  .. / .. / store / mod[toast_nofitication],
)

#' Dashboard module server
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
      ns <- session$ns

      fetch_goals <- \(token = rv_user()$token) {
        goals <- read_goals(token = rv_user()$token)
        goals <- rbindlist(l = goals$goals, use.names = TRUE)
        if (nrow(goals) == 0L) {
          data.table(`_id` = character(), text = character())
        } else {
          goals
        }
      }

      rv_goals <- reactiveVal()
      rv_selected_row <- reactiveVal()

      observeEvent(rv_user(), rv_goals(fetch_goals()))

      observeEvent(input$create, {
        goal <- input$new_goal
        req(goal)

        tryCatch(
          expr = {
            details <- create_goal(text = goal, token = rv_user()$token)
            rv_goals(fetch_goals())
            reset(id = "new_goal_form")
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
        language <- reactableLang(
          noData = "No goals found. Create some above."
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
          columns = columns,
          language = language
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
          rv_selected_row(selected_row)
          show <- isTruthy(selected_row)

          toggleClass(
            id = "btn_container",
            class = "d-none",
            condition = !show
          )

          toggleClass(
            id = "btn_container",
            class = "d-flex",
            condition = show
          )
        },
        ignoreNULL = FALSE
      )

      observeEvent(input$delete, {
        req(rv_selected_row())
        id <- rv_goals()[rv_selected_row(), `_id`]

        tryCatch(
          expr = {
            details <- delete_goal(id = id, token = rv_user()$token)
            rv_goals(fetch_goals())

            toast_nofitication(
              message = "Goal deleted",
              type = "success"
            )
          },
          error = req_error_handler
        )
      })

      observeEvent(input$cancel_edit, removeModal())

      observeEvent(input$edit, {
        req(rv_selected_row())
        text <- rv_goals()[rv_selected_row(), text]

        modal <- edit_goal_modal(ns = ns, text = text)
        showModal(modal)
      })

      observeEvent(input$confirm_edit, {
        text <- input$edited_goal
        req(rv_selected_row(), text)

        id <- rv_goals()[rv_selected_row(), `_id`]
        on.exit(removeModal())

        tryCatch(
          expr = {
            details <- update_goal(
              id = id,
              text = text,
              token = rv_user()$token
            )
            rv_goals(fetch_goals())

            toast_nofitication(
              message = "Goal updated",
              type = "success"
            )
          },
          error = req_error_handler
        )
      })
    }
  )
}
