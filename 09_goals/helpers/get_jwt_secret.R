#' Get jwt secret key
#' 
#' Looks for the variable `JWT_SECRET` in your .Renviron
#' @export 
get_jwt_secret <- \() {
  key <- Sys.getenv("JWT_SECRET")
  if (key == "") {
    stop(
      "JWT secret key not found.",
      " Set the `JWT_SECRET` variable in your .Renviron.",
      " You can use `uuid::UUIDgenerate()` to generate a secret key.",
      call. = FALSE
    )
  }
  key
}
