#' Get port to run app on from .Renviron file
#'
#' Looks for the env var `PORT`, if not found defaults
#' to `default`.
#' @param default Default value for the port in case none is set in
#' `.Renviron`
#' @return Character vector of length 1
#' @examples
#' \dontrun{
#' get_port()
#' }
#' @export
get_port <- \(default = 8000) {
  port <- Sys.getenv("PORT")
  port <- if (port == "") default else port
  as.integer(port)
}
