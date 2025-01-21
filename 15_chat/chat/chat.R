box::use(
  .. / ui[page, ],
)

#' @export
chat_get <- function(req, res) {
  res$send(page())
}

#' @export
chat_ws <- function(msg, ws) {
  ambiorix:::get_websocket_clients() |>
    lapply(\(c) {
      c$send("chat", msg)
    })
}
