box::use(
  htmltools[
    tags,
    tagList,
    HTML,
  ],
  . / create_href[create_href],
)

#' Generic HTML page
#'
#' @param ... Passed to the body tag of the html document.
#' @return [htmltools::tags]
#' @export
page <- \(...) {
  tagList(
    HTML("<!doctype html>"),
    tags$html(
      tags$head(
        tags$meta(charset = "utf-8"),
        tags$meta(
          name = "viewport",
          content = "width=device-width, initial-scale=1"
        ),
        tags$link(
          rel = "stylesheet",
          href = create_href("/static/styles.css")
        ),
        tags$link(
          rel = "stylesheet",
          href = create_href("/static/bootstrap-5.3.2-dist/bootstrap.min.css")
        ),
        tags$link(
          rel = "stylesheet",
          href = "https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css"
        ),
        tags$link(
          rel = "stylesheet",
          href = "https://cdn.datatables.net/v/bs5/jq-3.7.0/dt-1.13.8/datatables.min.css"
        ),
        tags$script(
          src = "https://cdn.datatables.net/v/bs5/jq-3.7.0/dt-1.13.8/datatables.min.js"
        ),
        tags$title("Home | Datatables")
      ),
      tags$body(
        class = "bg-light",
        ...,
        tags$script(
          type = "text/javascript",
          src = create_href(
            "/static/bootstrap-5.3.2-dist/bootstrap.bundle.min.js"
          )
        )
      )
    )
  )
}
