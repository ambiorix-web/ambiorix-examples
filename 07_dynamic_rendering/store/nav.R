box::use(
  htmltools[tags]
)

#' Navbar navigation links
#'
#' @param href A character vector. eg. c("/", "/about" "/contact")
#' @param label A character vector of same length as `href`.
#' Labels for the navigation links. eg. c("Home", "About", "Contact").
#' @param active A string. The current page. One of the options from
#' what you supplied to `label`.
#' @details Checkout [bootstrap nav](https://getbootstrap.com/docs/5.3/components/navbar/#nav) for more info
#' @examples
#' \dontrun{
#' nav(
#'   href = c("/", "/about", "/contact"),
#'   label = c("Home", "About", "Contact"),
#'   active = "Home"
#' )
#' }
#' @return An object of class `shiny.tag`
#' @export
nav <- \(
  href = c("/", "/about", "/contact"),
  label = c("Home", "About", "Contact"),
  active = "Home"
) {
  nav_items <- lapply(seq_along(href), \(i) {
    class <- paste("nav-link", if (label[i] == active) "active")
    aria_current <- if (label[i] == active) "page" else NULL
    tags$li(
      class = "nav-item",
      tags$a(
        class = class,
        `aria-current` = aria_current,
        href = href[i],
        label[i]
      )
    )
  })

  tags$nav(
    class = "navbar navbar-expand-lg shadow-sm mb-3",
    tags$div(
      class = "container",
      tags$a(
        class = "navbar-brand fw-bold",
        href = "/",
        "Axim"
      ),
      tags$button(
        class = "navbar-toggler",
        type = "button",
        `data-bs-toggle` = "collapse",
        `data-bs-target` = "#navbarNav",
        `aria-controls` = "navbarNav",
        `aria-expanded` = "false",
        `aria-label` = "Toggle navigation"
      ),
      tags$div(
        class = "collapse navbar-collapse d-flex justify-content-end",
        id = "navbarNav",
        tags$ul(
          class = "navbar-nav",
          nav_items
        )
      )
    )
  )
}
