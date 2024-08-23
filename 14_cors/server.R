box::use(
  ambiorix[Ambiorix],
)

#' Handle GET at '/'
#'
#' @export
hello_get <- \(req, res) {
  response <- list(
    code = 200L,
    msg = "hello, world"
  )
  res$set_status(200L)$json(response)
}

#' Allow CORS
#'
#' @details
#' Sets these headers in the response:
#' - `Access-Control-Allow-Methods`
#' - `Access-Control-Allow-Headers`
#' - `Access-Control-Allow-Origin`
#' @export
cors <- \(req, res) {
  res$header("Access-Control-Allow-Origin", "http://127.0.0.1:8000")

  if (req$REQUEST_METHOD == "OPTIONS") {
    res$header("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE")
    res$header(
      "Access-Control-Allow-Headers",
      req$HEADERS$`access-control-request-headers`
    )

    return(
      res$set_status(200L)$send("")
    )
  }
}

Ambiorix$
  new(host = "127.0.0.1", port = 5000L)$
  use(cors)$
  get("/", hello_get)$
  start()
