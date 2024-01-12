box::use(
  . / template_path[template_path],
  .. / store / contact[contact]
)

#' Contact
#'
#' Handler for GET requests at "/contact". Renders the contact page.
#'
#' @export
contact_get <- \(req, res) {
  res$render(
    template_path("page.html"),
    list(
      title = "Contact",
      content = contact()
    )
  )
}
