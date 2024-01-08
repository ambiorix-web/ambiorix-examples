box::use(./check_port[check_port])

#' Get port from .Renviron file
#'
#' Looks for the env var `PORT`
#' @inheritParams cli::cli_abort
#' @return Character vector of length 1
#' @examples
#' \dontrun{
#' get_port()
#' }
#' @export
get_port <- \(call = rlang::caller_env()) {
  check_port(call = call)
  Sys.getenv("PORT")
}
