library(ambiorix)

# port to listen on:
PORT <- 3000

# initialize a new ambiorix instance:
app <- Ambiorix$new()

# respond with “Hello World!” for requests to the root URL (/) or route:
app$get("/", \(req, res) {
  res$send("Hello World!")
})

# you can also use html tags:
app$get("/about", \(req, res) {
  res$send("<h1>About Us</h1>")
})

# start server:
app$start(port = PORT)
