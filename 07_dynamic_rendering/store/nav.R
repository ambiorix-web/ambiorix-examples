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
    class <- paste("nav-link", if (label[i] == active) "active border-bottom border-dark")
    aria_current <- if (label[i] == active) "page" else NULL
    tags$li(
      class = "nav-item",
      tags$a(
        class = class,
        `aria-current` = aria_current,
        # `data-bs-dismiss` = "offcanvas",
        href = href[i],
        label[i]
      )
    )
  })

  title <- "Axim"
  title_class <- "navbar-brand card-title text-uppercase fw-bold"
  tags$nav(
    class = "navbar navbar-expand-lg sticky-top mb-3 bg-white shadow-sm",
    tags$div(
      class = "container",
      tags$a(class = title_class, href = "/", title),
      tags$button(
        class = "navbar-toggler",
        type = "button",
        `data-bs-toggle` = "offcanvas",
        `data-bs-target` = "#offcanvasNavbar",
        `aria-controls` = "offcanvasNavbar",
        `aria-label` = "Toggle navigation",
        tags$span(class = "navbar-toggler-icon")
      ),
      tags$div(
        id = "offcanvasNavbar",
        class = "offcanvas offcanvas-end",
        tabindex = "-1",
        `aria-labelledby` = "offcanvasNavbarLabel",
        tags$div(
          class = "offcanvas-header",
          tags$h5(
            id = "offcanvasNavbarLabel",
            class = paste("offcanvas-title", title_class),
            title
          ),
          tags$button(
            class = "btn-close",
            type = "button",
            `data-bs-dismiss` = "offcanvas",
            `aria-label` = "Close"
          )
        ),
        tags$div(
          class = "offcanvas-body",
          tags$ul(
            class = "navbar-nav justify-content-end flex-grow-1 pe-3",
            nav_items
          )
        )
      )
    )
  )
}
