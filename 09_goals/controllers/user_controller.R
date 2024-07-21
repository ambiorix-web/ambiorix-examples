box::use(
  ambiorix[parse_multipart],
  sodium[password_store, password_verify],
  lubridate[now],
  shiny[isTruthy],
  .. / config / db[users_conn],
  .. / helpers / mongo_query[mongo_query],
  .. / helpers / generate_token[generate_token]
)

#' Register user
#'
#' POST `/api/users`. Public access.
#'
#' @export
register_user <- \(req, res) {
  body <- parse_multipart(req)
  name <- body$name
  email <- body$email
  password <- body$password

  if (!isTruthy(name) || !isTruthy(email) || !isTruthy(password)) {
    response <- list(msg = "Please add all fields")
    return(
      res$set_status(400L)$json(response)
    )
  }

  # check if user exists:
  found <- users_conn$find(
    query = mongo_query(email = email)
  )
  user_exists <- nrow(found) == 1L
  if (user_exists) {
    response <- list(msg = "User already exists")
    return(
      res$set_status(400L)$json(response)
    )
  }

  # hash password:
  hashed_password <- password_store(password)

  # create user:
  created_at <- now("UTC")
  updated_at <- created_at
  user <- data.frame(
    name = name,
    email = email,
    password = hashed_password,
    created_at = created_at,
    updated_at = updated_at
  )
  users_conn$insert(data = user)

  # get the created user:
  found <- users_conn$find(
    query = mongo_query(email = email),
    fields = mongo_query("_id" = TRUE, name = TRUE, email = TRUE)
  )
  user_exists <- nrow(found) == 1L
  if (!user_exists) {
    # if user was not created, return a 400 status:
    response <- list(msg = "Invalid user data")
    return(
      res$set_status(400L)$json(response)
    )
  }

  # add jwt:
  found$token <- generate_token(user_id = found$`_id`)

  res$set_status(201L)$json(found)
}

#' Authenticate user
#'
#' POST `/api/users/login`. Public access.
#' @export
login_user <- \(req, res) {
  body <- parse_multipart(req)
  email <- body$email
  password <- body$password

  if (!isTruthy(email) || !isTruthy(password)) {
    response <- list(msg = "Invalid credentials")
    return(
      res$set_status(400L)$json(response)
    )
  }

  # check user credentials:
  found <- users_conn$find(
    query = mongo_query(email = email),
    fields = mongo_query(
      "_id" = TRUE,
      name = TRUE,
      email = TRUE,
      password = TRUE
    )
  )

  user_exists <- nrow(found) == 1L
  if (!user_exists) {
    response <- list(msg = "Invalid credentials")
    return(
      res$set_status(400L)$json(response)
    )
  }

  password_okay <- password_verify(hash = found$password, password = password)
  if (!password_okay) {
    response <- list(msg = "Invalid credentials")
    return(
      res$set_status(400L)$json(response)
    )
  }

  # don't return password:
  found$password <- NULL
  # add jwt token:
  found$token <- generate_token(user_id = found$`_id`)

  res$json(found)
}

#' Get user data
#'
#' GET `/api/users/me`. Private access.
#' @export
get_me <- \(req, res) {
  # we already captured the logged in user in the `protect()` middleware
  me <- req$user
  if (is.null(me) || nrow(me) != 1L) {
    msg <- list(msg = "Not authorized")
    return(
      res$set_status(401L)$json(msg)
    )
  }
  res$json(me)
}
