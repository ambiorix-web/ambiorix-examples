# don't forget to import any deps up here using box::use()

#' Get all members controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal
#' @export
get_all_members <- \(req, res) {
  # <handle fetching all members here>
  response <- list(message = "Get all members (API v2)")
  res$set_status(200)$json(response)
}
