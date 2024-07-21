box::use(
  . / to_json[to_json]
)

#' Create a mongo query
#'
#' @param ... `key = value` pairs
#' @examples
#' mongo_query(a = 1, b = 2, c = 3, d = list(e = 5))
#' @export
mongo_query <- \(...) list(...) |> to_json()
