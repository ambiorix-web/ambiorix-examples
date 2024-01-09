box::use(
  ./get_db_path[get_db_path],
  DBI[dbConnect, dbDisconnect, dbReadTable, dbWriteTable],
  RSQLite[SQLite],
  dplyr
)

#' Delete member controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal
#' @export
delete_member <- \(req, res) {
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

  # otherwise, proceed to delete member:
  members <- members |> dplyr$filter(id != member_id)
  dbWriteTable(conn = conn, name = "members", value = members, overwrite = TRUE)

  response <- list(
    msg = "Member deleted successfully",
    members = members
  )
  res$json(response)
}
