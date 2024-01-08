#' Get all members controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal

get_all_members <- \(req, res) {
  res$json(.GlobalEnv$members)
}
