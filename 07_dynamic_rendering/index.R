box::use(
  ambiorix[Ambiorix],
  . / controllers / home_get[home_get],
  . / controllers / about_get[about_get],
  . / routers / contact[contact_router = router]
)

Ambiorix$
  new(port = 3000L)$
  static("public", "static")$
  get("/", home_get)$
  get("/about", about_get)$
  use(contact_router)$
  start(open = TRUE)
