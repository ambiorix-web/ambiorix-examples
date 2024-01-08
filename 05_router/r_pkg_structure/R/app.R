#' Core app
#'
#' @param port Port to run the app in. Defaults to [get_port()].
#' @export
app <- \(port = get_port()) {
  app <- ambiorix::Ambiorix$new()
  app$listen(port = port)
  app$use(members_router())
  app
}
