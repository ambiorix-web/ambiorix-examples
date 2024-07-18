## Goals

In this example, we will build a CRUD application backend: **Goals**.

You will be able to **C**reate, **R**ead, **U**pdate & **D**elete Goals.

Here's what's covered:

- Ambiorix + MongoDB
- Working with middleware:
  - Auth middleware: You will learn how you can use JSON Web Tokens ([JWT](https://jwt.io/)) to protect routes
  - Error handling middleware

## Prerequisites

- An installation of the community edition of [MongoDB](https://www.mongodb.com/docs/manual/installation/)
- The [mongolite](https://github.com/jeroen/mongolite) R pkg

## Run API

1. `cd` into the `09_goals/backend/` dir:

    ```bash
    cd 09_goals/backend/
    ```

1. Fire up R and restore package dependencies:

    ```r
    renv::restore()
    ```

1. `server.R` is the entry point. Run this command in the terminal to start the
   API:

    ```bash
    Rscript server.R
    ```
