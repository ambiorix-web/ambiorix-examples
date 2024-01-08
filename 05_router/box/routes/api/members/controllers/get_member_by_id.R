box::use(
  ./get_db_path[get_db_path],
  ambiorix[parse_multipart],
  DBI[dbConnect, dbDisconnect, dbReadTable],
  RSQLite[SQLite],
  dplyr
)

#' Get member by id controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal
#' @export
get_member_by_id <- \(req, res) {
  # get the supplied id:
  member_id <- req$params$id

  conn <- dbConnect(drv = SQLite(), get_db_path())
  on.exit(dbDisconnect(conn))
  members <- dbReadTable(conn = conn, name = "members")

  # filter member with that id:
  found <- members |> dplyr$filter(id == member_id)

  # if a member with that id was found, return the member:
  if (nrow(found) > 0) {
    return(res$json(found))
  }

  # otherwise, change response status to 400 (Bad Request)
  # and provide a message:
  msg <- list(msg = sprintf("No member with the id of %s", member_id))
  res$set_status(400L)$json(msg)
}
