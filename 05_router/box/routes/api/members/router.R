box::use(
  ambiorix[Router],
  . / controllers / get_all_members[get_all_members],
  . / controllers / get_member_by_id[get_member_by_id],
  . / controllers / create_new_member[create_new_member],
  . / controllers / update_member_info[update_member_info],
  . / controllers / delete_member[delete_member]
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
