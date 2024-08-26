getUserLocation <- function(req, res) {
    future({
        con <- connectToDatabase()

        if (is.list(con) && isTRUE(con$error)) {
            return(list(status = 500, data = list(error = con$message)))
        }

        on.exit(dbDisconnect(con), add = TRUE)
        cat("Database connection established\n")

        result <- tryCatch(
            {
                dbGetQuery(con, "SELECT name, latitude, longitude FROM users ORDER BY id DESC LIMIT 100")
            },
            error = function(e) {
                cat("Failed to execute query:", conditionMessage(e), "\n")
                return(list(error = TRUE, message = paste("Failed to execute query:", conditionMessage(e))))
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
            userLocation <- userLocationInfo(result)
            return(list(status = 200, data = userLocation))
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


getCountries <- function(latitudes, longitudes) {
    countriesSP <- getMap(resolution = "low")
    pointsSP <- SpatialPoints(data.frame(x = longitudes, y = latitudes), proj4string = CRS(proj4string(countriesSP)))
    countries <- over(pointsSP, countriesSP)$ADMIN
    return(countries)
}

getCountryCentroids <- function() {
    countriesSP <- getMap(resolution = "low")
    centroids <- coordinates(countriesSP)
    countryNames <- countriesSP$ADMIN
    centroidDF <- data.frame(country = countryNames, latitude = centroids[,2], longitude = centroids[,1])
    return(centroidDF)
}

userLocationInfo <- function(userLocationData) {
    userLocationData <- userLocationData %>%
        mutate(country = getCountries(latitude, longitude)) %>%
        group_by(country) %>%
        summarize(userCount = n()) %>%
        drop_na()

    countryCentroids <- getCountryCentroids()

    userLocationData <- userLocationData %>%
        left_join(countryCentroids, by = "country")

    return(userLocationData)
}

