box::use(
  readxl[read_xlsx],
  data.table[fread],
  ambiorix[Ambiorix],
  webutils[parse_http],
  cli[cli_alert_danger],
)

#' Handle GET at '/'
#'
#' @param req Request object.
#' @param res Response object.
#' @return `res$json()`
#' @export
home_get <- \(req, res) {
  response <- list(
    code = 200L,
    msg = "hello, world!"
  )

  res$json(response)
}

#' Handle POST at '/csv'
#'
#' @param req Request object.
#' @param res Response object.
#' @return `res$json()`
#' @export
csv_upload_post <- \(req, res) {
  postdata <- parse_http(
    body = req$rook.input$read(),
    content_type = req$CONTENT_TYPE
  )

  file_details <- postdata$file

  # check 'content_type' of file:
  ok <- identical(
    x = file_details$content_type,
    y = "text/csv"
  )
  # refer to common mime types:
  # https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types

  if (!ok) {
    response <- list(
      code = 400L,
      msg = "please upload a csv file"
    )

    return(
      res$json(body = response, status = 400L)
    )
  }

  # write file temporarily:
  temp <- tempfile(fileext = ".csv")
  on.exit(unlink(x = temp))
  writeBin(object = file_details$value, con = temp)

  # read file:
  x <- fread(file = temp)
  print(x)

  response <- list(
    code = 200L,
    msg = "file uploaded!"
  )

  res$json(response)
}

#' Handle POST at '/xlsx'
#'
#' @param req Request object.
#' @param res Response object.
#' @return `res$json()`
#' @export
xlsx_upload_post <- \(req, res) {
  postdata <- parse_http(
    body = req$rook.input$read(),
    content_type = req$CONTENT_TYPE
  )

  file_details <- postdata$file

  # check 'content_type' of file:
  ok <- identical(
    x = file_details$content_type,
    y = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
  )
  # refer to common mime types:
  # https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/MIME_types/Common_types

  if (!ok) {
    response <- list(
      code = 400L,
      msg = "please upload an xlsx file"
    )

    return(
      res$json(body = response, status = 400L)
    )
  }

  # write file temporarily:
  temp <- tempfile(fileext = ".xlsx")
  on.exit(unlink(x = temp))
  writeBin(object = file_details$value, con = temp)

  # read file:
  x <- read_xlsx(path = temp)
  print(x)

  response <- list(
    code = 200L,
    msg = "file uploaded!"
  )

  res$json(response)
}

#' 500 error handler middleware
#'
#' @param req Request object.
#' @param res Response object.
#' @param error Error object. See [stop()].
#' @return `res$json()`
#' @export
error_handler <- \(req, res, error = NULL) {
  if (!is.null(error)) {
    msg <- conditionMessage(error)
    cli_alert_danger(text = msg)
  }

  response <- list(
    code = 500L,
    msg = "A server error occurred!"
  )

  res$json(body = response, status = 500L)
}

app <- Ambiorix$new(port = 3000, host = "127.0.0.1")

# increase max body size to 35mb:
app$limit <- 35 * 1024 * 1024

app$
  set_error(error_handler)$
  get("/", home_get)$
  post("/xlsx", xlsx_upload_post)$
  post("/csv", csv_upload_post)$
  start()
