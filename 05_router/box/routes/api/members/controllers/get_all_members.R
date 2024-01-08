box::use(
  ./get_db_path[get_db_path],
  DBI[dbConnect, dbDisconnect, dbReadTable],
  RSQLite[SQLite]
)

#' Get all members controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal
#' @export
get_all_members <- \(req, res) {
  conn <- dbConnect(drv = SQLite(), get_db_path())
  on.exit(dbDisconnect(conn))

  members <- dbReadTable(conn = conn, name = "members")
  res$json(members)
}
