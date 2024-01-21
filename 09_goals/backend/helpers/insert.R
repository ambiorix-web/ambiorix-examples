box::use(
  uuid[UUIDgenerate],
  . / mongo_query[mongo_query]
)

#' Insert new document and retrieve its `_id`
#'
#' @param conn Mongo db connection from `mongolite::mongo()`
#' @param data Must be a data.frame, named list (for single record).
#' @param ... Named arguments passed to `conn$insert()`.
#' @return The new document, including its `_id` field.
#' @export
insert <- \(conn, data, ...) {
  tmp_oid <- UUIDgenerate(use.time = TRUE, n = 1L)
  data$`_tmp_oid` <- tmp_oid
  conn$insert(data = data, ...)
  # get the inserted document:
  doc <- conn$find(
    query = mongo_query("_tmp_oid" = tmp_oid),
    fields = mongo_query("_tmp_oid" = FALSE)
  )
  # remove the '_tmp_oid' field:
  conn$update(
    query = mongo_query("_tmp_oid" = tmp_oid),
    update = mongo_query(
      "$unset" = list("_tmp_oid" = TRUE)
    ),
    multiple = TRUE
  )
  doc
}
