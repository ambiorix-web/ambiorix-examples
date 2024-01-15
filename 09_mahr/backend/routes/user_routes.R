box::use(
  ambiorix[Router],
  .. / controllers / user_controller[
    register_user,
    login_user,
    get_me
  ]
)

#' Users router
#'
#' @export
router <- Router$
  new("/api/users")$
  post("/", register_user)$
  post("/login", login_user)$
  get("/me", get_me)
