box::use(
  ambiorix[parse_multipart]
)

#' Get goals
#'
#' GET `/api/goals`. Private access.
#' @export
get_goals <- \(req, res) {
  response <- list(message = "Get goals")
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
    msg <- list(message = "Please add a text field")
    return(
      res$
        set_status(400L)$
        json(msg)
    )
  }
  response <- list(message = "Set goal")
  res$json(response)
}

#' Update goal
#'
#' PUT `/api/goals/:id`. Private access.
#' @export
update_goal <- \(req, res) {
  id <- req$params$id
  response <- list(
    message = sprintf("Update goal %s", id)
  )
  res$json(response)
}

#' Delete goal
#'
#' DELETE `/api/goals/:id`. Private access.
#' @export
delete_goal <- \(req, res) {
  id <- req$params$id
  response <- list(
    message = sprintf("Delete goal %s", id)
  )
  res$json(response)
}
