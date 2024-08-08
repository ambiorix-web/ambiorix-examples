source("./controller/all_user_info.R")
source("./controller/user_count_info.R")
source("./controller/user_location_info.R")
source("./controller/user_gender_count.R")

router <- Router$new("/")


router$get("api/users", get_all_user_info)
router$get("api/user-count", get_user_count_info)
router$get("api/user-location", getUserLocation)
router$get("/api/status", function(req, res) {
  res$header("Access-Control-Allow-Origin", "*")
  res$header("Content-Type", "application/json")
  backendStatus <- list(
    status = 200,
    message = "ok"
  )
  print(toJSON(backendStatus, auto_unbox = TRUE))
  res$send(toJSON(backendStatus, auto_unbox = TRUE))
})

router$get("api/test", function(req, res) {
  str <- strftime(Sys.time(), "%Y-%m-%d %H:%M:%S")
  res$send(str)
})

router$get("api/user-gender-count/:year", get_user_gender_info)