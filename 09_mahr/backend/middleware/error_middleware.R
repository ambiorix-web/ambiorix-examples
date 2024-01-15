box::use(
  .. / helpers / operators[`%||%`]
)

#' Error handler
#'
#' @export
error_handler <- \(req, res) {
  response <- list(msg = "A server error occurred!")
  res$
    set_status(500L)$
    json(response)
}
