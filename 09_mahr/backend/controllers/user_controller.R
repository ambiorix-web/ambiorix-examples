#' Register user
#' 
#' POST `/api/users`. Public access.
#' 
#' @export 
register_user <- \(req, res) {
  res$json(list(msg = "Register user"))
}

#' Authenticate user
#' 
#' POST `/api/users/login`. Public access.
#' @export 
login_user <- \(req, res) {
  res$json(list(msg = "Login user"))
}

#' Get user data
#' 
#' GET `/api/users/me`. Private access.
#' @export 
get_me <- \(req, res) {
  res$json(list(msg = "User data display"))
}
