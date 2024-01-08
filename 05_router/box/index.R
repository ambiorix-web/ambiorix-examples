box::use(
  ambiorix[Ambiorix],
  . / helpers / get_port[get_port],
  . / middleware / logger[logger],
  . / routes / api / members / router[members_router = router]
)

Ambiorix$
  new()$
  listen(port = get_port())$
  use(logger)$
  use(members_router)$
  start(open = FALSE)
