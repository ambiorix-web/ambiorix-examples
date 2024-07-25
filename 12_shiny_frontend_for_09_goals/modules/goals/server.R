box::use(
  shiny[
    renderUI,
    is.reactive,
    moduleServer,
  ],
  cli[cli_abort],
  htmltools[tags],
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

      output$goals <- renderUI({
        tags$p("Goals will appear here")
      })
    }
  )
}
