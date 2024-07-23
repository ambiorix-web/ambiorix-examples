box::use(
  shiny[moduleServer],
)

#' Signup server module
#'
#' @param id String. Module id.
#' @export
server <- \(id) {
  moduleServer(
    id = id,
    module = \(input, output, session) {
      print("in signup")
    }
  )
}
