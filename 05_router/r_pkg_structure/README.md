## Using standard R package structure with ambiorix

Run the file [index.R](./index.R) to fire up the app.

> [!CAUTION]
> - In this example, I have commited the [.Renviron](./.Renviron) file. **NEVER** do that! This is just for example purposes and to kind of create a full reprex.
> - I have also used and manipulated a global env var (`.GlobalEnv$members`). Please **NEVER** do this. You should use a database instead.

Once you run the app, you'll be able to send requests via these endpoints:
- `GET`: `http://localhost:3000/api/members` : Gets all members
- `GET`: `http://localhost:3000/api/members/:id` : Get a single member by id
- `POST`: `http://localhost:3000/api/members` : Create a new member
- `PUT`: `http://localhost:3000/api/members/:id` : Update member info
- `DELETE`: `http://localhost:3000/api/members/:id` : Delete a member
