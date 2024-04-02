library(ambiorix)
PORT <- 3000

app <- Ambiorix$new()

app$get("/", \(req, res) {
  res$send("Hello World!")
})

app$post("/", \(req, res) {
  res$send("Got a POST request")
})

app$put("/user", \(req, res) {
  res$send("Got a PUT request at /user")
})

app$delete("/user", \(req, res) {
  res$send("Got a DELETE request at /user")
})

app$start(port = PORT)
