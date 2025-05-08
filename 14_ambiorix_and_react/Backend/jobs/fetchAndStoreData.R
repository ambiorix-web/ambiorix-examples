library(httr)
library(jsonlite)
library(DBI)
library(coro)
library(RPostgres)

callAndStoreUserData <- async(function() {
    data <- await(api_call())
    con <- connectToDatabase()
    await(storeUserData(con, data))
    dbDisconnect(con)
})

api_call <- async(function() {
    response <- GET("https://randomuser.me/api/")
    if (status_code(response) == 200) {
        result <- content(response, "text")

        return(result)
    } else {
        cat("API request failed :", status_code(response), "\n")
        return(NULL)
    }
})

storeUserData <- async(function(con, data) {
    if (!is.null(data)) {
        tryCatch(
            {
                parsed_data <- fromJSON(data, flatten = TRUE)

                if (is.data.frame(parsed_data$results) && nrow(parsed_data$results) > 0) {
                    result <- parsed_data$results[1, ]

                    if (!is.null(result$name.first) && !is.null(result$name.last)) {
                        name <- paste(result$name.first, result$name.last)
                    } else {
                        name <- NA
                    }

                    if(!is.null(result$gender)){
                        gender <- result$gender
                    } else{
                        gender <- NA
                    }

                    if (!is.null(result$registered.date)) {
                        registered_date <- tryCatch(as.Date(result$registered.date), error = function(e) NA)
                    } else {
                        registered_date <- NA
                    }

                    if (!is.null(result$phone)) {
                        phone_number <- result$phone
                    } else {
                        phone_number <- NA
                    }

                    if (!is.null(result$location.coordinates.latitude) && !is.null(result$location.coordinates.longitude)) {
                        latitude <- tryCatch(
                            round(as.numeric(result$location.coordinates.latitude), 6),
                            warning = function(w) NA,
                            error = function(e) NA
                        )
                        longitude <- tryCatch(
                            round(as.numeric(result$location.coordinates.longitude), 6),
                            warning = function(w) NA,
                            error = function(e) NA
                        )

                        
                    } else {
                        latitude <- NA
                        longitude <- NA
                    }

                    query <- sprintf(
                        "INSERT INTO users (name, registered_date, phone_number, latitude, longitude) VALUES ('%s', '%s', '%s', %s, %s)",
                        name, format(registered_date, "%Y-%m-%d"), phone_number, latitude, longitude
                    )

                    insertQuery <- sprintf(
                        "INSERT INTO users (name, registered_date, phone_number, latitude , longitude, gender) VALUES ('%s', '%s', '%s', '%s', '%s', '%s')",
                        name, format(registered_date, "%Y-%m-%d"), phone_number, latitude, longitude, gender
                    )
                    tryCatch(
                        {
                            dbExecute(con, insertQuery)
                        },
                        error = function(e) {
                            message(sprintf("Error in insertQuery: %s", e$message))
                        }
                    )

                    cat("User data stored successfully.\n")
                } else {
                    cat("Invalid or empty results in the API response. Data not stored.\n")
                }
            },
            error = function(e) {
                cat("Error parsing API response:", conditionMessage(e), "\n")
            }
        )
    } else {
        cat("Invalid API response. Data not stored.\n")
    }
})
