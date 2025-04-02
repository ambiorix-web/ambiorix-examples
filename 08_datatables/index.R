box::use(
  ambiorix[Ambiorix],
  . / controllers / home_get[home_get],
  . / controllers / flights_get[flights_get]
)

app <- Ambiorix$new(port = 3000L)
app$static("public", "static")
app$get("/", home_get)
app$get("/data/flights", flights_get)
app$start()
