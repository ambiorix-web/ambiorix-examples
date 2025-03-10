box::use(
  ambiorix[Ambiorix],
  . / chat[
    chat_get,
    chat_ws,
  ],
)

PORT <- 3000

app <- Ambiorix$new()

app$static("public", "static")

app$get("/", chat_get)
app$receive("chat", chat_ws)

app$start(port = PORT)
