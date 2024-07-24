box::use(
  shiny[shinyApp, addResourcePath],
  . / modules / mod[ui, server],
)

addResourcePath(
  prefix = "static",
  directoryPath = box::file("public")
)

shinyApp(
  ui = ui,
  server = server,
  options = list(
    port = 8000L,
    launch.browser = TRUE
  )
)
