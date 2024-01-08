#' Logger middleware
#'
#' @export
logger <- \(req, res) {
  msg <- paste0(
    req$rook.url_scheme,
    "://",
    req$HTTP_HOST,
    req$PATH_INFO,
    " ",
    format(Sys.time(), "%Y-%m-%d %H:%M:%S %Z")
  )
  cat("\nLogger: ", msg, "\n\n")
}
