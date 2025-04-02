box::use(
  .. / utils / in_prod[in_prod],
)

#' Create an anchor tag's href attribute
#'
#' @description
#' Generates the `href` for an anchor (`<a>`) tag. If the application is
#' running in a production environment, the given `path` is prefixed to
#' the `href` to ensure the correct base URL is used.
#'
#' @param href String. `href` attribute of an anchor tag (e.g., "/about").
#' @param base_path String. Base path on which the app is deployed. eg.,
#' if the app is deployed at `https://try.ambiorix.dev/infinite-scroll`,
#' the environment variable `APP_BASE_PATH` should be set to `/infinite-scroll`.
#' The default value is obtained from the `APP_BASE_PATH` environment variable,
#' or it can be passed directly.
#'
#' @return String. The complete `href` for the anchor tag.
#'
#' @examples
#' # In production, this may return "/infinite-scroll/about":
#' create_href("/about")
#'
#' @export
create_href <- \(href, base_path = Sys.getenv("APP_BASE_PATH")) {
  if (in_prod()) {
    href <- paste0(base_path, href)
  }
  href
}
