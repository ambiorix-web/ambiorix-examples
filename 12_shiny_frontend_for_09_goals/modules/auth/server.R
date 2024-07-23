box::use(
  shiny[moduleServer],
  . / signup_server[signup_server = server],
)

#' Auth module server
#'
#' @param id String. Module id.
#' @export
server <- \(id) {
  moduleServer(
    id = id,
    module = \(input, output, session) {
      signup_server(id = "signup")
    }
  )
}
