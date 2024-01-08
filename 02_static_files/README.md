## Serving static files in ambiorix

To serve static files such as images, CSS files, and JavaScript
files, use the `app$static()` method.

For example, let's say this is your directory structure:

```
|- index.R
|- public/
    |- index.html
    |- about.html
    |- image.jpg
    |- css
        |- styles.css
    |- index2.R
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

## Serve regular files

Take a look at:
- [public/about.html](public/about.html)
- [public/index.html](public/index.html)
- [public/index2.R](public/index2.R)

Now run the app ([index.R](index.R)) and navigate to these links in your browser:
- http://localhost:3000/static/index.html
- http://localhost:3000/static/about.html
- http://localhost:3000/static/index2.R

By making the `public/` folder static, any resource placed there can be
accessed via the browser.

This is usually not what you're going to use ambiorix for. For
the most part you're going to either:
- Build APIs so that you can connect from a frontend like React et al, OR,
- Render templates where you can insert dynamic data rather than just having a static website.

## Keep this in mind:

- All static files are exposed and can be accessed via the browser. DO NOT put sensitive files there.
- You can also use [htmltools](https://rstudio.github.io/htmltools/index.html) tags instead of writing html strings.
