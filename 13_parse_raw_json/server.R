box::use(
  ambiorix[Ambiorix],
  webutils[parse_http],
)

#' Handle POST at '/'
#'
#' @param req Request object.
#' @param res Response object.
#' @return `res$json()`
#' @export
home_post <- \(req, res) {
  content_type <- req$CONTENT_TYPE
  body <- req$rook.input$read()

  if (length(body) == 0L) {
    response <- list(
      code = 400L,
      msg = "Invalid request"
    )

    return(
      res$set_status(400L)$json(response)
    )
  }

  postdata <- parse_http(body, content_type)

  # filter & select as necessary:
  row_inds <- iris$Species %in% postdata$species
  col_inds <- colnames(iris) %in% postdata$cols
  data <- iris[row_inds, col_inds, drop = FALSE]

  response <- list(
    code = 200L,
    msg = "success",
    data = data
  )

  res$json(response)
}

app <- Ambiorix$new(port = 3000, host = "127.0.0.1")

app$
  post("/", home_post)$
  start()
