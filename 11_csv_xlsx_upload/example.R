box::use(
  curl[form_file],
  httr2[
    request,
    req_perform,
    req_url_path,
    last_response,
    resp_body_json,
    req_body_multipart,
  ]
)

base_url <- "http://127.0.0.1:3000"
file <- form_file(
  path = "iris.csv",
  type = "text/csv",
  name = "iris.csv"
)

req <- request(base_url = base_url) |>
  req_url_path("/csv") |>
  req_body_multipart(file = file)

# use `tryCatch()` in case an error occurs while performing the request:
tryCatch(
  expr = req |>
    req_perform() |>
    resp_body_json(),
  error = \(e) {
    print("An error occurred!")
    error <- last_response() |> resp_body_json()
    print(error)
  }
)
