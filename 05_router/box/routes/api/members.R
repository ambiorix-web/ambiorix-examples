box::use(
  ambiorix[Router],
  . / members / controllers[...]
)

#' @export
router <- Router$new("/api/members")

# get all members:
router$get("/", get_all_members)

# get a single member:
router$get("/:id", get_member_by_id)

# create a new member:
router$post("/", create_new_member)

# update member info:
router$put("/:id", update_member_info)

# delete member:
router$delete("/:id", delete_member)
