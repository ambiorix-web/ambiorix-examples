box::use(
  ./get_db_path[get_db_path],
  .. / .. / .. / helpers / operators[`%||%`],
  ambiorix[parse_multipart],
  DBI[dbConnect, dbDisconnect, dbReadTable, dbWriteTable],
  RSQLite[SQLite],
  dplyr
)

#' Update member controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal
#' @export
update_member_info <- \(req, res) {
  # get the supplied id:
  member_id <- req$params$id

  conn <- dbConnect(drv = SQLite(), get_db_path())
  on.exit(dbDisconnect(conn))
  members <- dbReadTable(conn = conn, name = "members")

  # filter member with that id:
  found <- members |> dplyr$filter(id == member_id)

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
  dbWriteTable(conn = conn, name = "members", value = members, overwrite = TRUE)

  response <- list(
    msg = "Member updated successfully",
    member = found
  )
  res$json(response)
}
