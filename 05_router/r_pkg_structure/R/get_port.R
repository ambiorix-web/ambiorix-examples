#' Get port from .Renviron file
#'
#' Looks for the env var `PORT`
#' @inheritParams cli::cli_abort
#' @return Character vector of length 1
#' @examples
#' \dontrun{
#' get_port()
#' }
get_port <- \(call = rlang::caller_env()) {
  check_port(call = call)
  Sys.getenv("PORT")
}
