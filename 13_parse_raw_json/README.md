# Parse raw JSON

Say you have an API endpoint that expects raw JSON data. How do you parse that?

This example answers that and is in a way related to the example on [csv & xlsx upload](../11_csv_xlsx_upload).

This is a simple example revolving around how you can select columns and filter
rows in the `iris` dataset when the request body is something like this:

```json
{
    "cols": ["Sepal.Length", "Petal.Width", "Species"],
    "species": ["virginica", "setosa"]
}
```

# Run API

1. `cd` into the `13_parse_raw_json/` dir:

   ```bash
   cd 13_parse_raw_json/
   ```
1. Fire up R and restore package dependencies:

   ```r
   renv::restore()
   ```
1. `server.R` is the entry point. Run this command in the terminal to start the API:

   ```bash
   Rscript server.R
   ```
