box::use(
  nycflights13[flights],
  dplyr,
  .. / store / datatable[make_user_friendly_names]
)
#' Get flights data
#'
#' Handler for GET requests at "/data/flights".
#' @export
flights_get <- \(req, res) {
  draw <- req$query$draw
  start_row <- as.integer(req$query$start) + 1L # datatables use 0-based indexing (JS)
  num_of_rows <- as.integer(req$query$length) - 1L
  end_row <- start_row + num_of_rows

  search_res <- flights

  # perform search:
  search_value <- req$query$`search[value]`
  if (!is.null(search_value)) {
    found <- lapply(flights, \(cl) {
      grepl(pattern = search_value, x = cl, ignore.case = TRUE)
    }) |>
      as.data.frame() |>
      rowSums(na.rm = TRUE)
    found <- which(found > 0)
    search_res <- flights |> dplyr$slice(found)
  }

  records_filtered <- nrow(search_res)

  # filter out the requested rows:
  row_inds <- seq(from = start_row, to = end_row, by = 1L)
  filtered <- search_res |> dplyr$slice(row_inds)

  names(filtered) <- names(filtered) |> make_user_friendly_names()

  # datatable expects json:
  response <- list(
    draw = draw,
    recordsTotal = nrow(flights),
    recordsFiltered = records_filtered,
    data = filtered
  )
  res$json(response)
}
