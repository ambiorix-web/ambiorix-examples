#' Is a value falsy?
#'
#' @description
#' A falsy value is either:
#' * `NULL`
#' * An empty string ""
#' * Has a length of 0
#' A truthy value is the opposite of that.
#' Please note that this is not a check for whether a value is `TRUE` or
#' `FALSE`.
#' @param x Value to check.
#' @examples
#' is_falsy("") # TRUE
#' is_falsy("m") # FALSE
#' is_falsy(NULL) # TRUE
#' is_falsy(character(0L)) # TRUE
#'
#' is_truthy("") # FALSE
#' is_truthy("m") # TRUE
#' is_truthy(NULL) # FALSE
#' is_truthy(character(0L)) # FALSE
#' @return Logical.
#' @export
is_falsy <- \(x) {
  is.null(x) || identical(x, "") || length(x) == 0L
}

#' Is a value truthy?
#'
#' @rdname is_falsy
#' @export
is_truthy <- Negate(is_falsy)
