# CORS middleware

This example shows how you can add a CORS middleware to your API.

This is useful when making cross-origin requests from the browser (client-side).

# Run API

1. `cd` into the `14_cors/` dir:

   ```bash
   cd 14_cors/
   ```
1. Fire up R and restore package dependencies:

   ```r
   renv::restore()
   ```
1. `server.R` is the entry point. Run this command in the terminal to start the API:

   ```bash
   Rscript server.R
   ```
