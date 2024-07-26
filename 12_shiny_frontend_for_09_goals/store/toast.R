box::use(
  shinytoastr[
    toastr_info,
    toastr_error,
    toastr_success,
    toastr_warning,
  ]
)

#' Toast notification with custom defaults
#'
#' @param title String. Title to show on top of the toast.
#' @param message String. Message to show.
#' @param time_out Numeric. How long notification should be kept on screen,
#' in milliseconds. See [shinytoastr::toastr_error()].
#' @param type String. Type of toast. Either "error" (default), "success",
#' "info" or "warning".
#' @export
toast_nofitication <- \(
  title = "",
  message = "",
  time_out = 5000,
  type = c("error", "success", "info", "warning")
) {
  type <- match.arg(arg = type)
  f <- switch(
    EXPR = type,
    error = toastr_error,
    success = toastr_success,
    info = toastr_info,
    warning = toastr_warning
  )

  f(
    title = title,
    message = message,
    timeOut = time_out,
    position = "bottom-center",
    progressBar = TRUE,
    closeButton = TRUE
  )
}
