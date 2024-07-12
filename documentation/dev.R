DT <- data.table::data.table(
  a = c(1, NA, 2, NA, 3, NA),
  b = c(NA, 2, NA, 1, NA, 0),
  c = letters[1:6]
)

DT

non_int_bear_prop <- c("a", "b")

data.table::setnafill(
  x = DT,
  type = "const",
  fill = 0,
  cols = non_int_bear_prop
)

# DT[, non_int_bear := 0]

# for (prop in non_int_bear_prop) {
#   DT[, non_int_bear := non_int_bear + get(prop)]
# }

# DT[]

DT[
  ,
  non_int_bear := rowSums(.SD),
  .SDcols = non_int_bear_prop
]
