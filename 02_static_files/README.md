## Serving static files in ambiorix

To serve static files such as images, CSS files, and JavaScript
files, use the `app$static()` method.

For example, let's say this is your directory structure:

```
|- index.R
|- public/
    |- image.png
    |- styles.css
    |- main.js
```

### `/public`

To make the files accessible at the path `/public`, you'd do this:

```r
app$static(path = "public", uri = "public")
```

- `path` specifies the static directory.
- `uri` defines the path ambiorix should serve the static files from.

So now you'll be able to do this in your app:

```r
app$get("/", \(req, res) {
  res$send(
    "<h1>Hello everyone!</h1>
    <img src='public/image.jpg'/>"
  )
})
```

Also, note that you can access every static resource by navigating to it from the browser eg. [http://localhost:3000/public/image.jpg](http://localhost:3000/public/image.jpg)

### `/your-own-path`

You can make static content accessible via your own custom path too.

For example, let's use `/static` this time:

```r
app$static(path = "public", uri = "static")
```

Then in your code you'll use this:

```r
app$get("/", \(req, res) {
  res$send(
    "<h1>Hello everyone!</h1>
    <img src='static/image.jpg'/>"
  )
})
```

## Keep this in mind:

- All static files are exposed and can be accessed via the browser. DO NOT put sensitive files there.
- You can also use [htmltools](https://rstudio.github.io/htmltools/index.html) tags instead of writing html strings.
