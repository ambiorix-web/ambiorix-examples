box::use(
  htmltools[tags],
  bslib[page, bs_theme],
  shinytoastr[useToastr],
  shiny[
    shinyApp,
    tabsetPanel,
    tabPanelBody,
    observeEvent,
    addResourcePath,
  ],
  . / modules / auth / mod[auth_ui, auth_server],
  . / modules / goals / mod[goals_ui, goals_server],
)

addResourcePath(
  prefix = "static",
  directoryPath = box::file("public")
)

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

server <- \(input, output, session) {
  switch_to_tab <- \(tab) {
    freezeReactiveValue(x = input, name = "pages")
    updateTabsetPanel(
      session = session,
      inputId = "pages",
      selected = tab
    )
  }

  r_user <- auth_server(id = "auth")

  observeEvent(r_user(), switch_to_tab("goals"))
}

shinyApp(
  ui = ui,
  server = server,
  options = list(
    port = 8000L,
    launch.browser = TRUE
  )
)
