## Routing

**Routing** refers to how an application's endpoints (URIs) respond to client requests.

For an introduction to routing, see [03_basic_routing](../03_basic_routing/).

If you look at [04_simple_json_api/index.R](../04_simple_json_api/index.R) you'll notice that the routes we created all belong to `/api/members` and we kept repeating that base/root route.

Wouldn't it be nice to only have to use `/` and `/:id` and have ambiorix prepend the `/api/members` automatically?

That would give you a better app structure making it manageable.

Enter **ambiorix::Router()**.

Use the `ambiorix::Router` class to create modular, mountable router handlers.

A `Router` instance is a complete middleware and routing system; for this reason, it is often referred to as a "mini-app".

Using the example [04_simple_json_api/index.R](../04_simple_json_api/index.R), this is how we would transform it:

```r
# members.R
members_router <- \() {
  router <- Router$new("/members")

  # get all members:
  router$get("/", \(req, res) {
    # ...
  })

  # get a single member:
  router$get("/:id", \(req, res) {
    # ...
  })

  # create a new member:
  router$post("/", \(req, res)) {
    # ...
  }

  # update member:
  router$put("/:id", \(req, res) {
    # ...
  })

  # delete member:
  router$delete("/:id", \(req, res) {
    # ...
  })

  router
}
```

The `index.R` file would now be:

```r
library(ambiorix)

# <bring/import the members.R file>

PORT <- 3000

app <- Ambiorix$new()

# mount the router:
app$use(members_router())

app$start(port = PORT, open = FALSE)
```

> [!NOTE]
> Ambiorix is unopinionated. As such, it is up to you to decide how you want to bring/export the `members.R` file into `index.R`.
> Some options are:
> - Use [box](https://klmr.me/box/) (**Highly recommended, ⭐⭐⭐⭐⭐**) especially if you develop large apps/systems, for two reasons:
>     1. Allows nested files, folders & modules (a big win)
>     2. Explicit name imports ie. you're almost always sure from which package a function is from.
> - Use R package structure (**Recommended, ⭐⭐⭐⭐**). Will not allow nested folders but will work really well for small to medium apps.
> - `source()` files (**NOT recommended, 1⭐**). Haha. Iykyk.

I provide 2 examples:
- One [using box](/box), and,
- Another [using standard R package structure](/r_pkg_structure)
