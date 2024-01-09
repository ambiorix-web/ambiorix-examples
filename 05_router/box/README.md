## Using [{box}](https://klmr.me/box/index.html) with [{ambiorix}](https://ambiorix.dev/)

I highly recommend this way of building apps.

As you go through the code, you will easily notice how modularized it is.

{box} enables you to split your app into small, manageable & interconnected modules:

```bash
.
├── data
│   ├── get_db_path.R
│   └── members.sqlite
├── helpers
│   ├── check_port.R
│   ├── get_port.R
│   └── operators.R
├── index.R
├── middleware
│   └── logger.R
├── models
│   └── members.R
├── README.md
└── routes
    └── api
        ├── members
        │   ├── controllers.R
        │   ├── create_new_member.R
        │   ├── delete_member.R
        │   ├── get_all_members.R
        │   ├── get_db_path.R
        │   ├── get_member_by_id.R
        │   └── update_member_info.R
        └── members.R
```

> [!CAUTION]
> You'll notice that I've used an sqlite file. The table "members" is very small,
> that's why I read the whole table and write it again as much as I want.
> Again, this is just for purposes of a reprex.
> In the real world, you should write sql-interpolated queries to the database.
>
> **NEVER** commit a database file or a `.Renviron` file!

Once you run the app, you'll be able to send requests via these endpoints:
- `GET`: `http://localhost:3000/api/members` : Gets all members
- `GET`: `http://localhost:3000/api/members/:id` : Get a single member by id
- `POST`: `http://localhost:3000/api/members` : Create a new member
- `PUT`: `http://localhost:3000/api/members/:id` : Update member info
- `DELETE`: `http://localhost:3000/api/members/:id` : Delete a member
