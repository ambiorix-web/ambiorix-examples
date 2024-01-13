box::use(
  htmltools[tags, tagList],
  nycflights13[flights],
  . / nav[nav],
  . / create_card[create_card],
  . / datatable[datatable, make_user_friendly_names]
)

#' The "Home" page
#'
#' @return An object of class `shiny.tag`
#' @export
home <- \() {
  tagList(
    nav(),
    tags$div(
      class = "container",
      create_card(
        title = "Data Tables",
        title_icon = tags$i(class = "bi bi-grid"),
        title_class = "text-primary",
        class = "shadow-sm",
        tags$p("R users love tables, and so do we!"),
        tags$p(
          "Enter",
          tags$a(
            href = "https://datatables.net/",
            "DataTables."
          )
        ),
        tags$p(
          "In the example below, we show how you can use serverside processing
          if your data is huge."
        )
      ),
      create_card(
        title = NULL,
        title_icon = NULL,
        title_class = "text-primary",
        class = "shadow-sm mt-3 mb-5",
        # you will mostly get the column names from the database
        datatable(
          col_names = names(flights) |> make_user_friendly_names(),
          table_id = "flights",
          table_class = "table-hover table-striped table-borderless table-sm",
          processing = TRUE,
          serverSide = TRUE,
          searchDelay = 1500,
          # send a GET request (the default for ajax) to "/data/flights"
          ajax = "/data/flights",
          columnDefs = list(
            list(
              # handle missing values:
              defaultContent = "",
              # avoid cell wrap:
              className = "dt-nowrap",
              targets = "_all"
            )
          ),
          # enable horizontal scrolling:
          scrollX = TRUE
        )
      )
    )
  )
}
