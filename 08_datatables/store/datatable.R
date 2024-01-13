box::use(
  htmltools[tags, tagList],
  jsonlite[toJSON],
  stringr[str_replace_all, str_to_title]
)

#' Generate html to create a datatable
#'
#' Meant to be used for serverside rendering of [datatables](https://datatables.net/)
#'
#' @param col_names Column names of the data.
#' @param table_id Table id.
#' @param table_class Bootstrap classes to apply to the table.
#' @param ... Named `key=value` pairs. Table options. Don't include 'columns'.
#' See [datatable options](https://datatables.net/manual/options).
#' @return An object of class `shiny.tag`
#' @export
datatable <- \(
  col_names,
  table_id,
  table_class = NULL,
  ...
) {
  tagList(
    tags$table(
      id = table_id,
      class = paste("table", table_class),
      tags$thead(
        tags$tr(
          lapply(col_names, \(col_name) {
            tags$th(scope = "col", col_name)
          })
        )
      ),
      tags$tbody()
    ),
    tags$script(
      datatable_script(
        id = table_id,
        col_names = col_names,
        ...
      )
    )
  )
}

#' Make a script to convert a table to datatable
#'
#' @param id Table id.
#' @param col_names Column names of the data.
#' @param ... Named `key=value` pairs. Table options. Don't include 'columns'.
#' See [datatable options](https://datatables.net/manual/options).
#' @examples
#' script <- datatable_script(
#'   id = "datatable",
#'   col_names = names(iris),
#'   processing = TRUE,
#'   serverSide = TRUE,
#'   ajax = "/api/data"
#' )
#'
#' cat(script, "\n")
#' @return String. JavaScript code.
#' @export
datatable_script <- \(id, col_names, ...) {
  columns <- lapply(col_names, \(name) list(data = name))
  opts <- list(
    ...,
    columns = columns
  ) |>
    toJSON(auto_unbox = TRUE, pretty = TRUE)
  sprintf(
    "$(document).ready(function() {
      $('#%s').DataTable(%s);
    });",
    id,
    opts
  )
}

#' Make user friendly names
#'
#' @param names Names to make user-friendly
#' @return Character vector of same length as `names`
#' @export
make_user_friendly_names <- \(names) {
  names |>
    str_replace_all(pattern = "_", replacement = " ") |>
    str_to_title()
}
