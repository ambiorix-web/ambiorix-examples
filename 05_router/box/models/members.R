# box::use(
#   RSQLite[SQLite],
#   DBI[dbConnect, dbWriteTable, dbListTables]
# )

# #' The members "model"
# #'
# members <- data.frame(
#   id = character(),
#   name = character(),
#   email = character(),
#   status = character()
# )

# conn <- dbConnect(SQLite(), file.path("data", "members.sqlite"))

# dbWriteTable(conn = conn, "members", members)
