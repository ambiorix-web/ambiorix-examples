#' Update member controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal
update_member_info <- \(req, res) {
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

  # otherwise, proceed to update member:
  body <- parse_multipart(req)

  # only update provided fields:
  found$name <- body$name %||% found$name
  found$email <- body$email %||% found$email
  found$status <- body$status %||% found$status

  members[members$id == found$id, ] <- found
  .GlobalEnv$members <- members

  response <- list(
    msg = "Member updated successfully",
    member = found
  )
  res$json(response)
}
