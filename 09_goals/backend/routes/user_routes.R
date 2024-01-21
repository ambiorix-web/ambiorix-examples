box::use(
  ambiorix[Router],
  .. / controllers / user_controller[
    register_user,
    login_user,
    get_me
  ],
  .. / middleware / auth_middleware[protect]
)

#' Users router
#'
#' @export
router <- Router$
  new("/api/users")$
  use(protect)$
  post("/", register_user)$
  post("/login", login_user)$
  get("/me", get_me)
