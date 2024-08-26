get_user_gender_info <- function(req, res) {
  year <- req$params$year
  print(year)
  future({
    con <- connectToDatabase()

    if (is.list(con) && isTRUE(con$error)) {
      return(list(status = 500, data = list(error = con$message)))
    }

    on.exit(dbDisconnect(con), add = TRUE)
    cat("Database connection established\n")

    getQuery  <-  sprintf("SELECT gender FROM users WHERE EXTRACT(YEAR FROM registered_date) = '%s'", year)
    result <- tryCatch(
      {
        dbGetQuery(con, getQuery)
      },
      error = function(e) {
        cat("Failed to execute query:", conditionMessage(e), "\n")
        return(list(error = TRUE, message = paste("Failed to execute getQuery:", conditionMessage(e))))
      }
    )

    if (is.list(result) && isTRUE(result$error)) {
      cat(result$message, "\n")
      return(list(status = 500, data = list(error = result$message)))
    }

    if (is.null(result) || nrow(result) == 0) {
      cat("No users found\n")
      return(list(status = 404, data = list(message = "No users found.")))
    } else {
      userGenderCount <- userGenderCount(result)
      return(list(status = 200, data = userGenderCount))
    }
  }) %...>%
    {
      if (.$status == 500) {
        res$set_status(500)
        res$header("Access-Control-Allow-Origin", "*")
        res$header("Content-Type", "application/json")
        res$send(toJSON(.$data))
      } else if (.$status == 404) {
        res$set_status(404)
        res$header("Access-Control-Allow-Origin", "*")
        res$header("Content-Type", "application/json")
        res$send(toJSON(.$data))
      } else {
        json_data <- toJSON(.$data, pretty = TRUE)
        res$header("Access-Control-Allow-Origin", "*")
        res$header("Content-Type", "application/json")
        res$send(json_data)
      }
    } %...!% {
      cat("Unexpected error:", conditionMessage(.), "\n")
      res$set_status(500)
      res$header("Access-Control-Allow-Origin", "*")
      res$header("Content-Type", "application/json")
      res$send(toJSON(list(error = "Unexpected server error")))
    }
}


userGenderCount <- function(userData) {
   genderDistribution <- userData %>%
        group_by(gender) %>%
        summarize(count = n()) %>%
        mutate(percentage = (count / sum(count)) * 100)

  return(genderDistribution)
}
