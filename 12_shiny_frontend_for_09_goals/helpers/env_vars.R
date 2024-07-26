box::use(
  cli[cli_abort],
  rlang[caller_env],
)

#' Get the backend's base url
#'
#' Checks for the env var `BASE_URL` in your .Renviron
#' @param call [rlang::caller_env()] Environment of the calling function.
#' @return String.
#' @export
get_base_url <- \(call = caller_env()) {
  base_url <- Sys.getenv("BASE_URL")

  not_found <- identical(base_url, "")
  if (not_found) {
    cli_abort(
      message = c(
        "x" = "env var {.envvar BASE_URL} not found in the project's {.file .Renviron}",
        "i" = "Did you forget to set it and restart your R session?"
      )
    )
  }

  base_url
}
