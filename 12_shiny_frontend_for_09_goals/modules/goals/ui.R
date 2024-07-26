box::use(
  shiny[
    NS,
    icon,
    uiOutput,
    actionLink,
    actionButton,
    tabsetPanel,
    tabPanelBody,
  ],
  htmltools[tags],
  . / account_ui[account_ui = ui],
  . / dashboard_ui[dashboard_ui = ui],
)

#' Create user profile btn
#'
#' @param ns Module namespace from which this function is called.
#' @param user_name String. User name.
#' @return [htmltools::tags$div()]
#' @export
user_profile_btn <- \(ns, user_name) {
  tags$div(
    class = "dropdown",
    actionButton(
      inputId = ns("show_account_options"),
      class = "dropdown-toggle",
      icon = icon(name = NULL, class = "fa fa-user-large"),
      `data-bs-toggle` = "dropdown",
      `aria-expanded` = "false",
      label = user_name
    ),
    tags$ul(
      class = "dropdown-menu",
      tags$li(
        actionLink(
          inputId = ns("logout"),
          label = "Logout"
        )
      ),
      tags$li(
        actionLink(
          inputId = ns("go_to_account_settings"),
          label = "Account"
        )
      )
    )
  )
}

#' Goals UI module
#'
#' @param id String. Module id.
#' @return [htmltools::tags$div()]
#' @export
ui <- \(id) {
  ns <- NS(id)

  header <- tags$div(
    class = "d-flex justify-content-between align-items-center my-4",
    tags$h4(
      class = "m-0",
      "Goals"
    ),
    uiOutput(outputId = ns("user_profile_btn"))
  )

  tags$div(
    class = "container",
    header,
    tabsetPanel(
      id = ns("tabs"),
      type = "hidden",
      selected = "dashboard",
      tabPanelBody(
        value = "dashboard",
        dashboard_ui(id = ns("dashboard"))
      ),
      tabPanelBody(
        value = "account",
        account_ui(id = ns("account"))
      )
    )
  )
}
