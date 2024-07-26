box::use(
  cli[cli_abort],
  shinyjs[toggleClass],
  cookies[remove_cookie],
  shiny[
    req,
    isTruthy,
    reactive,
    showModal,
    reactiveVal,
    removeModal,
    is.reactive,
    observeEvent,
    moduleServer,
  ],
  data.table[
    setnames,
    transpose,
    as.data.table,
  ],
  reactable[
    reactable,
    renderReactable,
    getReactableState,
  ],
  . / account_ui[
    edit_field_modal,
    delete_account_modal,
  ],
  .. / auth / mod[
    login,
    delete_account,
    req_error_handler,
    update_account_details,
  ],
  .. / .. / store / mod[toast_nofitication],
)

#' Account moduel server
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

      rv_user_dt <- reactiveVal()
      rv_selected_row <- reactiveVal()

      observeEvent(rv_user(), {
        x <- append(
          x = rv_user(),
          values = list(password = "**********")
        ) |>
          as.data.table()

        x[, c("_id", "token") := NULL]

        dt <- transpose(l = x, keep.names = "key")

        setnames(
          x = dt,
          old = "V1",
          new = "value"
        )

        rv_user_dt(dt)
      })

      output$account_details <- renderReactable({
        reactable(
          data = rv_user_dt(),
          wrap = FALSE,
          highlight = TRUE,
          bordered = TRUE,
          resizable = TRUE,
          pagination = FALSE,
          onClick = "select",
          selection = "single"
        )
      })

      observeEvent(
        eventExpr = getReactableState(
          outputId = "account_details",
          name = "selected"
        ),
        handlerExpr = {
          selected_row <- getReactableState(
            outputId = "account_details",
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

      observeEvent(
        eventExpr = c(input$cancel_edit, input$cancel_deletion),
        handlerExpr = removeModal()
      )

      observeEvent(input$edit, {
        req(rv_selected_row())
        key <- rv_user_dt()[rv_selected_row(), key]
        value <- rv_user_dt()[rv_selected_row(), value]

        modal <- edit_field_modal(
          ns = ns,
          field = key,
          text = value
        )
        showModal(modal)
      })

      observeEvent(input$confirm_edit, {
        req(rv_selected_row())
        key <- rv_user_dt()[rv_selected_row(), key]

        is_name <- identical(key, "name")
        is_email <- identical(key, "email")
        is_password <- identical(key, "password")

        prev_id <- paste0("prev_", key)
        old_value <- input[[prev_id]]

        new_id <- paste0("new_", key)
        new_value <- input[[new_id]]

        req(new_value)

        all_ok <- TRUE
        if (is_password) {
          req(old_value)
          all_ok <- tryCatch(
            expr = {
              login(email = rv_user()$email, password = old_value)
              TRUE
            },
            error = \(e) {
              req_error_handler(e)
              FALSE
            }
          )
        }

        if (!all_ok) {
          return()
        }

        on.exit(removeModal())

        tryCatch(
          expr = {
            details <- update_account_details(
              name = if (is_name) new_value,
              email = if (is_email) new_value,
              password = if (is_password) new_value,
              token = rv_user()$token
            )$user

            details$token <- rv_user()$token
            rv_user(details)

            toast_nofitication(
              message = "Success!",
              type = "success"
            )
          },
          error = req_error_handler
        )
      })

      observeEvent(input$delete, {
        showModal(delete_account_modal(ns = ns))
      })

      observeEvent(input$confirm_deletion, {
        tryCatch(
          expr = {
            delete_account(token = rv_user()$token)
            remove_cookie(cookie_name = "auth")
            toast_nofitication(
              message = "Account deleted!",
              type = "success"
            )
            session$reload()
          },
          error = req_error_handler
        )
      })

      res <- reactive({
        list(
          go_back_to_dashboard = input$go_back_to_dashboard
        )
      })

      return(res)
    }
  )
}
