box::use(
  ambiorix[parse_multipart],
  .. / config / db[goals_conn],
  .. / helpers / mongo_query[mongo_query],
  .. / helpers / to_json[to_json]
)

#' Get goals
#'
#' GET `/api/goals`. Private access.
#' @export
get_goals <- \(req, res) {
  # remember we set the user on the req object at `protect()`:
  goals <- goals_conn$find(
    query = mongo_query(user_id = req$user$`_id`),
    fields = mongo_query("_id" = TRUE, text = TRUE)
  )
  res$json(goals)
}

#' Set a goal
#'
#' POST `/api/goals`. Private access.
#' @export
set_goal <- \(req, res) {
  body <- parse_multipart(req)
  text <- body$text
  if (is.null(text)) {
    msg <- list(message = "Please add a text field")
    return(
      res$set_status(400L)$json(msg)
    )
  }
  
  goal <- data.frame(user_id = req$user$`_id`, text = text)
  goals_conn$insert(data = goal)
  res$json(goal)
}

#' Update goal
#'
#' PUT `/api/goals/:id`. Private access.
#' @export
update_goal <- \(req, res) {
  id <- req$params$id
  goal <- goals_conn$find(
    query = mongo_query(
      user_id = req$user$`_id`,
      "_id" = list("$oid" = id)
    ),
    fields = mongo_query("_id" = TRUE, text = TRUE)
  )
  
  if (nrow(goal) == 0) {
    msg <- list(msg = "Goal not found")
    return(
      res$set_status(400L)$json(msg)
    )
  }
  
  body <- parse_multipart(req)
  text <- body$text

  goals_conn$update(
    query = mongo_query(
      user_id = req$user$`_id`,
      "_id" = list("$oid" = id)
    ),
    update = mongo_query(
      "$set" = list(text = text)
    )
  )

  updated_goal <- goals_conn$find(
    query = mongo_query(
      user_id = req$user$`_id`,
      "_id" = list("$oid" = id)
    ),
    fields = mongo_query("_id" = TRUE, text = TRUE)
  )

  response <- list(
    msg = "Goal updated successfully",
    goal = updated_goal
  )
  res$json(response)
}

#' Delete goal
#'
#' DELETE `/api/goals/:id`. Private access.
#' @export
delete_goal <- \(req, res) {
  id <- req$params$id
  goal <- goals_conn$find(
    query = mongo_query(
      user_id = req$user$`_id`,
      "_id" = list("$oid" = id)
    ),
    fields = mongo_query("_id" = TRUE, text = TRUE)
  )
  
  if (nrow(goal) == 0) {
    msg <- list(msg = "Goal not found")
    return(
      res$set_status(400L)$json(msg)
    )
  }
  
  goals_conn$remove(
    query = mongo_query(
      user_id = req$user$`_id`,
      "_id" = list("$oid" = id)
    )
  )

  response <- list(
    msg = "Goal deleted successfully",
    goal = goal
  )

  res$json(response)
}
