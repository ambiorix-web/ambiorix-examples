## datatables

how to use [datatables](https://datatables.net/) in ambiorix:

- rendering
- pagination

## deployment

### `.Renviron`

set these env vars when deploying:

```
APP_ENV = prod
APP_BASE_PATH = /datatables
```

setting the `APP_BASE_PATH` variable is only important if you're deploying
the app at a sub-path.

for example, if the app is deployed at `https://try.ambiorix.dev/datatables`,
the env var `APP_BASE_PATH` should be set to `/datatables`.

### Docker

- build docker image:

    ```
    sudo docker build -t datatables .
    ```

- start services:

    ```
    docker compose up -d --remove-orphans
    ```

    The app is now accessible on the host machine at **port 3001**.

- stop services in this context:

    ```
    sudo docker compose down
    ```
