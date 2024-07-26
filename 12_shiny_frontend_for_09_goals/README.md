# Goals

This is a frontend for example [`09_goals`](../09_goals). Built using `{shiny}`.

# Features

- Auth:
  - Custom sign up & login pages
  - Cookies: Auto-login next time you visit/reload the app
- APIs:
  - Make API requests to the backend using `{httr2}`
  - Handle any request errors gracefully via `tryCatch()`

# Installation

1. First make sure that the backend is running. See how [here](../09_goals).
1. `cd` into the dir `12_shiny_frontend_for_09_goals/`:

    ```bash
    cd 12_shiny_frontend_for_09_goals/
    ```

1. Fire up R & restore pkg dependencies:

    ```r
    renv::restore()
    ```

1. Add these env vars to your `.Renviron`:

    ```r
    BASE_URL = http://127.0.0.1:5000
    RENV_CONFIG_SANDBOX_ENABLED = FALSE
    ```

1. `app.R` is the entry point. Run this on the terminal to start the app:

```bash
Rscript app.R
```
