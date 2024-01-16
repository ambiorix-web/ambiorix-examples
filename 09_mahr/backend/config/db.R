box::use(
  mongolite[mongo],
  jsonlite[toJSON]
)

#' Goals db connection
#' 
#' @export 
goals_conn <- mongo(collection = "goals", db = "mahr_tutorial")

#' Users db connection
#' 
#' @export 
users_conn <- mongo(collection = "users", db = "mahr_tutorial")
