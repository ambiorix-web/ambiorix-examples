config <- read_yaml("config.yml")
postgres_config <- config$default$postgres


connectToDatabase <- function(dbname = postgres_config$dbname, autoCreateDb = FALSE) {
  tryCatch({
    con <- dbConnect(
      Postgres(),
      user = postgres_config$user,
      host = postgres_config$host,
      password = postgres_config$password,
      dbname = ifelse(autoCreateDb, "postgres", dbname),
      port = postgres_config$port
    )
    return(con)
  }, error = function(e) {
    cat("Failed to connect to database:", conditionMessage(e), "\n")
    return(list(error = TRUE, message = paste("Failed to connect to database:", conditionMessage(e))))
  })
}