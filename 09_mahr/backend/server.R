box::use(
  ambiorix[Ambiorix],
  . / helpers / get_port[get_port],
  . / middleware / error_middleware[error_handler],
  . / routes / goal_routes[goal_router = router]
)

app <- Ambiorix$new()

app$error <- error_handler

app$
  use(goal_router)$
  start(port = get_port(), open = FALSE)
