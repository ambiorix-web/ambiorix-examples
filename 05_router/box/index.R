box::use(
  ambiorix[Ambiorix],
  . / helpers / get_port[get_port],
  . / middleware / logger[logger],
  . / routes / api / members
)

Ambiorix$
  new()$
  listen(port = get_port())$
  use(logger)$
  use(members$router)$
  start(open = FALSE)
