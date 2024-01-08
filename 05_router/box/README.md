## Using [{box}](https://klmr.me/box/index.html) with [{ambiorix}](https://ambiorix.dev/)

I highly recommend this way of building apps.

As you go though the code, you will easily notice how modularized it is.
It shows how you can split your app into small, manageable & interconnected chunks:
- `data/`
  - `members.sqlite`
- `helpers/`
- `middleware/`
- `models/`
- `routes/`
  - `api`
    - `members`
      - `controllers`
- `index.R`

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
