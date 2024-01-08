library(ambiorix)
library(htmltools)
PORT <- 3000

app <- Ambiorix$new()

app$static(path = "public", "static")

app$get("/", \(req, res) {
  res$send(
    tags$div(
      tags$h1("Hello everyone"),
      tags$img(src = file.path("static", "image.jpg"))
    )
  )
})

app$start(port = PORT)

# run the app and navigate to these links in your browser:
# - http://localhost:3000/static/index.html
# - http://localhost:3000/static/about.html
# - http://localhost:3000/static/index2.R
