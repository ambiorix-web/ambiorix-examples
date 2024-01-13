box::use(
  ambiorix[Ambiorix],
  . / controllers / home_get[home_get],
  . / controllers / flights_get[flights_get]
)

Ambiorix$
  new(port = 3000L)$
  static("public", "static")$
  get("/", home_get)$
  get("/data/flights", flights_get)$
  start(open = TRUE)
