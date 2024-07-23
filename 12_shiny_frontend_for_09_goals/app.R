box::use(
  shiny[shinyApp, addResourcePath],
  htmltools[tags],
  bslib[page, bs_theme],
  . / modules / auth / mod[auth_ui, auth_server],
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
  auth_ui(id = "auth")
)

server <- \(input, output, session) {
  auth_server(id = "auth")
}

shinyApp(
  ui = ui,
  server = server,
  options = list(
    port = 8000L
  )
)
