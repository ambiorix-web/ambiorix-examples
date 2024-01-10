## Multiple routers

You can have multiple routers mounted onto `ambiorix::Ambiorix` via the `use()` method.

In this example, I show how you can version your api.

Remember, ambiorix is unopinionated. This is just my way of doing things.

You'll see that using [{box}](https://github.com/klmr/box) is the easiest way to split up &
organize your files & folders.

This is the directory structure that I've used:

```
.
├── api
│   ├── members.R
│   ├── v1
│   │   ├── members
│   │   │   ├── controllers.R
│   │   │   ├── create_new_member.R
│   │   │   ├── delete_member.R
│   │   │   ├── get_all_members.R
│   │   │   ├── get_member_by_id.R
│   │   │   └── update_member_info.R
│   │   └── members.R
│   └── v2
│       ├── members
│       │   ├── controllers.R
│       │   ├── create_new_member.R
│       │   ├── delete_member.R
│       │   ├── get_all_members.R
│       │   ├── get_member_by_id.R
│       │   └── update_member_info.R
│       └── members.R
├── index.R
└── README.md
```

This is how `index.R` looks like:

```r
box::use(
  ambiorix[Ambiorix],
  . / api / members
)

Ambiorix$
  new()$
  listen(port = 3000L)$
  use(members$v1)$ # mount API v1 members' router
  use(members$v2)$ # mount API v2 members' router
  start(open = FALSE)
```

Once you run the app, you should be able to perform requests on
http://localhost:3000/api/v*/members, eg.

- `GET` request on `http://localhost:3000/api/v1/members`
- `PUT` request on `http://localhost:3000/api/v2/members/:3`

... and so on.

Checkout the routers at:
- [v1 members router](./api/v1/members.R)
- [v2 members router](./api/v2/members.R)
