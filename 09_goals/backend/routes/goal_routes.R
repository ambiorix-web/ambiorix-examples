box::use(
  ambiorix[Router],
  .. / controllers / goal_controller[
    get_goals,
    set_goal,
    update_goal,
    delete_goal
  ],
  .. / middleware / auth_middleware[protect]
)

#' Goal router
#'
#' @export
router <- Router$
  new("/api/goals")$
  use(protect)$
  get("/", get_goals)$
  post("/", set_goal)$
  put("/:id", update_goal)$
  delete("/:id", delete_goal)
