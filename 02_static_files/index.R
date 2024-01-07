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
