# don't forget to import any deps up here using box::use()

#' Delete member controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal
#' @export
delete_member <- \(req, res) {
  # <handle member deletion here>
  response <- list(message = "Delete member (API v2)")
  res$set_status(200)$json(response)
}
