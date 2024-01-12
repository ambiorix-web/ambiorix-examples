box::use(
  . / template_path[template_path],
  .. / store / about[about]
)

#' About
#'
#' Handler for GET requests at "/about". Renders the about page.
#'
#' @export
about_get <- \(req, res) {
  res$render(
    template_path("page.html"),
    list(
      title = "About",
      content = about()
    )
  )
}
