#' Is app running in prod?
#'
#' @return Logical.
#' @export
in_prod <- \() {
  identical(
    Sys.getenv("APP_ENV"),
    "prod"
  )
}
