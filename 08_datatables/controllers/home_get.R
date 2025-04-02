box::use(
  .. / store / home[home]
)

#' Home
#'
#' Handler for GET requests at "/". Renders the homepage.
#'
#' @export
home_get <- \(req, res) {
  res$send(home())
}
