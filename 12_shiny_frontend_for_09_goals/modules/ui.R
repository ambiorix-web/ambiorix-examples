box::use(
  htmltools[tags],
  bslib[page, bs_theme],
  shinytoastr[useToastr],
  shiny[
    tabsetPanel,
    tabPanelBody,
  ],
  . / auth / mod[auth_ui],
  . / goals / mod[goals_ui],
)

#' App UI
#'
#' @export
ui <- page(
  title = "Goals",
  theme = bs_theme(version = 5, preset = "bootstrap"),
  lang = "en",
  tags$head(
    tags$script(src = "static/script.js")
  ),
  useToastr(),
  tabsetPanel(
    id = "pages",
    type = "hidden",
    selected = "auth",
    tabPanelBody(
      value = "auth",
      auth_ui(id = "auth")
    ),
    tabPanelBody(
      value = "goals",
      goals_ui(id = "goals")
    )
  )
)
