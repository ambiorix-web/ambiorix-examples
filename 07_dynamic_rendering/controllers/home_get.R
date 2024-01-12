box::use(
  . / template_path[template_path],
  .. / store / home[home]
)

#' Home
#'
#' Handler for GET requests at "/". Renders the homepage.
#'
#' @export
home_get <- \(req, res) {
  res$render(
    template_path("page.html"),
    list(
      title = "Home",
      content = home()
    )
  )
}
