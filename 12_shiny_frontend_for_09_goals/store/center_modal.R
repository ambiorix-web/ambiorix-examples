#' Center modal dialog
#'
#' Vertically and horizontally centers [shiny::modalDialog]
#'
#' @param modal [shiny::modalDialog]
#' @inherit email_verification_modal examples
#' @return The centered modal dialog tags
#' @export
center_modal <- \(modal) {
  modal_tag_q <- modal |> htmltools::tagQuery()
  modal_tag_q$find(".modal-dialog")$addClass("modal-dialog-centered")
  modal_tag_q$allTags()
}
