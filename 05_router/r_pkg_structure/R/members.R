#' The members data.frame
#'
#' This is a global variable. This is NOT a good practice. It is here for
#' example purposes ie. to provide a complete reprex.
#' Please NEVER do this. You should use a database instead.
members <- data.frame(
  id = as.character(1:3),
  name = c("John Doe", "Bob Williams", "Shannon Jackson"),
  email = c("john@gmail.com", "bob@gmail.com", "shannon@gmail.com"),
  status = c("active", "inactive", "active")
)

.GlobalEnv$members <- members
