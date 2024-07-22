box::use(
  jose[jwt_decode_hmac],
  .. / config / db[users_conn],
  .. / helpers / mongo_query[mongo_query],
  .. / helpers / get_jwt_secret[get_jwt_secret]
)

#' Get protected routes
#'
#' Returns the start string of protected routes
#' @return Character vector.
protected_paths <- \() {
  c(
    "/api/users/me",
    "/api/goals"
  )
}

#' Check if path is protected
#'
#' @return Logical.
is_protected_path <- \(req_path_info) {
  startsWith(x = req_path_info, prefix = protected_paths()) |> any()
}

#' Protect routes
#'
#' @export
protect <- \(req, res) {
  # check if route is private:
  path_info <- req$PATH_INFO
  if (!is_protected_path(path_info)) {
    return(res)
  }

  auth_headers <- req$HEADERS$authorization
  is_valid <- !is.null(auth_headers) &&
    startsWith(x = auth_headers, prefix = "Bearer")

  response_401 <- list(
    code = 401L,
    msg = "Not authorized"
  )

  if (!is_valid) {
    return(
      res$set_status(401L)$json(response_401)
    )
  }

  tryCatch(
    expr = {
      # get token from header:
      token <- strsplit(x = auth_headers, split = " ")[[1]][[2]]
      # verify the token:
      decoded <- jwt_decode_hmac(jwt = token, secret = get_jwt_secret())
      # get user id from the token:
      user_id <- decoded$user_id
      # find the user:
      found <- users_conn$find(
        query = mongo_query(
          "_id" = list("$oid" = user_id)
        ),
        fields = mongo_query(`_id` = TRUE, name = TRUE, email = TRUE)
      )
      # set the user in the request object:
      req$user <- found
    },
    error = \(e) {
      print(e)
      res$set_status(401L)$json(response_401)
    }
  )
}
