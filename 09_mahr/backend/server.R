box::use(
  ambiorix[Ambiorix],
  . / helpers / get_port[get_port],
  . / routes / goal_routes[goal_router = router]
)

Ambiorix$
  new()$
  use(goal_router)$
  start(port = get_port())
