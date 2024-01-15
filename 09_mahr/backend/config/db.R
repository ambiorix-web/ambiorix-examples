box::use(
  mongolite[mongo],
  jsonlite[toJSON]
)

#' Goals db connection
#' 
#' @export 
goals_conn <- mongo(collection = "goals", db = "mahr_tutorial")
