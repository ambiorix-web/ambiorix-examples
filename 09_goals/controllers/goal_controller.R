box::use(
  ambiorix[parse_multipart],
  .. / config / db[goals_conn],
  .. / helpers / mongo_query[mongo_query],
  .. / helpers / to_json[to_json],
  .. / helpers / insert[insert]
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

  response <- list(goals = goals)

  res$json(response)
}

#' Set a goal
#'
#' POST `/api/goals`. Private access.
#' @export
set_goal <- \(req, res) {
  body <- parse_multipart(req)
  text <- body$text

  if (is.null(text)) {
    response <- list(
      code = 400L,
      msg = "Please add a 'text' field in the body"
    )
    return(
      res$set_status(400L)$json(response)
    )
  }

  goal <- data.frame(user_id = req$user$`_id`, text = text)
  doc <- insert(conn = goals_conn, data = goal)
  response <- list(
    code = 201L,
    msg = "Success.",
    goal = as.list(doc)
  )

  res$set_status(201L)$json(response)
}

#' Update goal
#'
#' PUT `/api/goals/:id`. Private access.
#' @export
update_goal <- \(req, res) {
  id <- req$params$id
  goal <- tryCatch(
    expr = goals_conn$find(
      query = mongo_query(
        user_id = req$user$`_id`,
        "_id" = list("$oid" = id)
      ),
      fields = mongo_query("_id" = TRUE, text = TRUE)
    ),
    error = \(e) {
      print(e)
      data.frame()
    }
  )

  if (nrow(goal) == 0) {
    response <- list(
      code = 400L,
      msg = "Goal not found"
    )
    return(
      res$set_status(400L)$json(response)
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
    code = 200L,
    msg = "Goal updated successfully",
    goal = as.list(updated_goal)
  )
  res$json(response)
}

#' Delete goal
#'
#' DELETE `/api/goals/:id`. Private access.
#' @export
delete_goal <- \(req, res) {
  id <- req$params$id
  goal <- tryCatch(
    expr = goals_conn$find(
      query = mongo_query(
        user_id = req$user$`_id`,
        "_id" = list("$oid" = id)
      ),
      fields = mongo_query("_id" = TRUE, text = TRUE)
    ),
    error = \(e) {
      print(e)
      data.frame()
    }
  )

  if (nrow(goal) == 0) {
    msg <- list(
      code = 400L,
      msg = "Goal not found"
    )
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
    code = 200L,
    msg = "Goal deleted successfully",
    goal = as.list(goal)
  )

  res$json(response)
}
