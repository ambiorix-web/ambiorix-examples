box::use(
  ambiorix[Ambiorix],
  . / api / members
)

Ambiorix$
  new()$
  listen(port = 3000L)$
  use(members$v1)$ # mount API v1 members' router
  use(members$v2)$ # mount API v2 members' router
  start(open = FALSE)
