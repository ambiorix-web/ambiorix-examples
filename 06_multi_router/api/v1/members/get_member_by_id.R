# don't forget to import any deps up here using box::use()

#' Get member by id controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal
#' @export
get_member_by_id <- \(req, res) {
  # <handle a single member by id here>
  response <- list(message = "Get a single member by id (API v1)")
  res$set_status(200)$json(response)
}
