# don't forget to import any deps up here using box::use()

#' Create new member controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal
#' @export
create_new_member <- \(req, res) {
  # <handle member creation here>
  response <- list(message = "Create new member (API v1)")
  res$set_status(200)$json(response)
}
