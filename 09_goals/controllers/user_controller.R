box::use(
  ambiorix[parse_multipart],
  sodium[password_store, password_verify],
  lubridate[now],
  .. / config / db[users_conn, goals_conn],
  .. / helpers / truthiness[is_falsy, is_truthy],
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

  if (is_falsy(name) || is_falsy(email) || is_falsy(password)) {
    response <- list(
      code = 400L,
      msg = "Please add all fields"
    )
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
    response <- list(
      code = 409L,
      msg = "User already exists!"
    )
    return(
      res$set_status(409L)$json(response)
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
    # if user was not created, return a 500 status:
    response <- list(
      code = 500L,
      msg = "Invalid user data"
    )
    return(
      res$set_status(500L)$json(response)
    )
  }

  # add jwt:
  found$token <- generate_token(user_id = found$`_id`)

  response <- list(
    code = 201L,
    msg = "Success.",
    user = as.list(found)
  )

  res$set_status(201L)$json(response)
}

#' Authenticate user
#'
#' POST `/api/users/login`. Public access.
#' @export
login_user <- \(req, res) {
  body <- parse_multipart(req)
  email <- body$email
  password <- body$password

  invalid_creds_response <- list(
    code = 401L,
    msg = "Invalid credentials"
  )

  if (is_falsy(email) || is_falsy(password)) {
    return(
      res$set_status(401L)$json(invalid_creds_response)
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
    return(
      res$set_status(401L)$json(invalid_creds_response)
    )
  }

  password_okay <- password_verify(hash = found$password, password = password)
  if (!password_okay) {
    return(
      res$set_status(401L)$json(invalid_creds_response)
    )
  }

  # don't return password:
  found$password <- NULL
  # add jwt token:
  found$token <- generate_token(user_id = found$`_id`)

  response <- list(
    code = 200L,
    msg = "Success.",
    user = as.list(found)
  )

  res$json(response)
}

#' Get user data
#'
#' GET `/api/users/me`. Private access.
#' @export
get_me <- \(req, res) {
  # we already captured the logged in user in the `protect()` middleware
  me <- req$user
  if (is_falsy(me) || nrow(me) != 1L) {
    msg <- list(
      code = 401L,
      msg = "Not authorized"
    )
    return(
      res$set_status(401L)$json(msg)
    )
  }

  response <- list(
    code = 200L,
    msg = "Success.",
    user = as.list(me)
  )
  res$json(response)
}

#' Update user data
#'
#' PUT at `/api/users/me`. Private access.
#' @export
update_me <- \(req, res) {
  me <- req$user
  if (is_falsy(me) || nrow(me) != 1L) {
    msg <- list(
      code = 401L,
      msg = "Not authorized"
    )
    return(
      res$set_status(401L)$json(msg)
    )
  }

  body <- parse_multipart(req)
  password <- body$password
  new_details <- list(
    name = body$name,
    email = body$email,
    password = if (is_truthy(password)) {
      password_store(password)
    }
  ) |>
    Filter(f = Negate(is.null))

  # if there are no new details, just return a 200:
  if (length(new_details) == 0L) {
    response <- list(
      code = 200L,
      msg = "No updates made. Retaining user details."
    )
    return(
      res$json(response)
    )
  }

  # create the query & update statements:
  query <- mongo_query(
    `_id` = list(
      `$oid` = me$`_id`
    )
  )
  update <- mongo_query(
    `$set` = new_details
  )

  # update:
  users_conn$update(query = query, update = update)

  # get the updated user:
  fields <- mongo_query(`_id` = TRUE, name = TRUE, email = TRUE)
  new_me <- users_conn$find(
    query = query,
    fields = fields
  )

  response <- list(
    code = 200L,
    msg = "Updated successfully!",
    user = new_me
  )

  res$json(response)
}

#' Delete user account
#'
#' DELETE at `/api/users/me`. Private access.
#' @export
delete_me <- \(req, res) {
  me <- req$user
  if (is_falsy(me) || nrow(me) != 1L) {
    msg <- list(
      code = 401L,
      msg = "Not authorized"
    )
    return(
      res$set_status(401L)$json(msg)
    )
  }

  query <- mongo_query(
    `_id` = list(
      `$oid` = me$`_id`
    )
  )
  users_conn$remove(query = query)

  # delete this users's goals:
  query <- mongo_query(user_id = me$`_id`)
  goals_conn$remove(query = query)

  response <- list(
    code = 200L,
    msg = "Account deleted"
  )

  res$json(response)
}
