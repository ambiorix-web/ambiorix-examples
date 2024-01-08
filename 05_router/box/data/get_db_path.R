#' Get database path
#' @export
get_db_path <- \() {
  file.path(box::file(), "members.sqlite")
}
