box::use(
  jsonlite[toJSON]
)

#' Convert R objects to JSON with some custom defaults
#'
#' @inheritParams jsonlite::toJSON
#' @examples
#' query <- list(
#'   name = "Larry",
#'   age = 32,
#'   gpa = 2.8,
#'   fullTime = FALSE,
#'   registerDate = lubridate::now("UTC"),
#'   courses = c("Biology", "Chemistry", "Calculus"),
#'   address = list(
#'     street = "123 Fake St.",
#'     city = "Bikini Bottom",
#'     zip = 12345
#'   )
#' ) |>
#'   to_json()
#'
#' query
#' @export
to_json <- \(x, pretty = TRUE, auto_unbox = TRUE, ...) {
  toJSON(x = x, pretty = TRUE, auto_unbox = TRUE, ...)
}
