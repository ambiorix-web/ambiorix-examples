# don't forget to import any deps up here using box::use()

#' Update member controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal
#' @export
update_member_info <- \(req, res) {
  # <handle updating member info here>
  response <- list(message = "Update member info (API v2)")
  res$set_status(200)$json(response)
}
