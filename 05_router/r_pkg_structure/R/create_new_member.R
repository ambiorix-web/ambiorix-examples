#' Create new member controller function
#'
#' @inheritParams handler
#' @name views
#' @keywords internal
create_new_member <- \(req, res) {
  # parse form-data:
  body <- parse_multipart(req)

  name <- body$name
  email <- body$email
  status <- body$status

  # require all member details:
  if (is.null(name) || is.null(email) || is.null(status)) {
    msg <- list(msg = "Please include a name, email & status")
    return(res$set_status(400L)$json(msg))
  }

  # details of the new member:
  new_member <- data.frame(
    id = uuid::UUIDgenerate(),
    name = name,
    email = email,
    status = status
  )

  # save new member:
  .GlobalEnv$members <- dplyr::bind_rows(members, new_member)

  # respond with a message and details of the newly created member:
  response <- list(
    msg = "Member created successfully!",
    member = new_member
  )

  res$json(response)
}
