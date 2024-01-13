#' Template path
#'
#' Create a path to `templates/`
#' @export
template_path <- \(...) {
  file.path(box::file(), ...)
}
