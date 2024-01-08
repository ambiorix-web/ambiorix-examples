#' Delete member controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal
delete_member <- \(req, res) {
  # get the supplied id:
  member_id <- req$params$id

  members <- .GlobalEnv$members
  # filter member with that id:
  found <- members |> dplyr::filter(id == member_id)

  # if a member with that id is NOT found, change response status
  # and provide a message:
  if (nrow(found) == 0) {
    msg <- list(msg = sprintf("No member with the id of %s", member_id))
    return(res$set_status(400L)$json(msg))
  }

  # otherwise, proceed to delete member:
  .GlobalEnv$members <- members |> dplyr::filter(id != member_id)

  response <- list(
    msg = "Member deleted successfully",
    members = .GlobalEnv$members
  )
  res$json(response)
}
