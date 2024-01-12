box::use(
  ambiorix[Router],
  .. / controllers / contact[
    contact_get,
    contact_post,
    validate_email,
    validate_message
  ]
)

#' @export
router <- Router$new("/contact")

router$
  get("/", contact_get)$
  post("/", contact_post)$
  post("/email", validate_email)$
  post("/message", validate_message)
