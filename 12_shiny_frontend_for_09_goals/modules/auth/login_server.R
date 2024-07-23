box::use(
  shiny[
    reactive,
    moduleServer,
    observeEvent,
  ],
)

#' Login server module
#'
#' @param id String. Module id.
#' @export
server <- \(id) {
  moduleServer(
    id = id,
    module = \(input, output, session) {
      observeEvent(input$password, {
        print("passwording...")
      })

      r_res <- reactive({
        list(
          go_to_signup = input$signup
        )
      })
      return(r_res)
    }
  )
}
