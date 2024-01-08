box::use(cli[cli_abort])
#' Checks if the env var `PORT` is set
#'
#' @inheritParams cli::cli_abort
#' @return `TRUE` (invisibly) if the env var `PORT` is found in `.Renviron`.
#' Otherwise, throws an error.
#' @examples
#' \dontrun{
#' check_port()
#' }
#' @export
check_port <- \(call = rlang::caller_env()) {
  if (Sys.getenv("PORT") == "") {
    cli_abort(
      message = c(
        "x" = "Env var {.envvar PORT} not found.",
        "i" = "Please set it in your {.file .Renviron} and restart the R session."
      ),
      call = call
    )
  }
  invisible(TRUE)
}
