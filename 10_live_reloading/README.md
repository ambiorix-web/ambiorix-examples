## Live Reloading

When building applications (whether backend or frontend), it gets tiring to manually stop & restart the app when you make changes to the source code.

This guide shows you how you can monitor files for changes and have the app restart automatically.

> [!NOTE]
> This is not something specific to ambiorix, but it is extremely useful during my development process, so I saw it a good idea to have it included as part of the examples.

## Prerequisites

- A working installation of [nodejs](https://nodejs.org/en) & [npm](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm)

In case you'd like to know, we won't be writing any JavaScript.

## Setup

1. You of course need to have an app. You can use any of the code in the previous examples. We will use a simple `server.R` file, which is also the entrypoint:
    ```R
      library(ambiorix)

      app <- Ambiorix$new()

      app$get("/", \(req, res){
        res$send("Using {ambiorix}!")
      })

      app$get("/about", \(req, res){
        res$text("About")
      })

      app$start()
    ```

2. Change to your project's root dir.
   
   ```bash
   cd myproject
   ```
3. Initialize an npm project & create the `package.json` file:

   ```bash
   npm init -y
   ```
    The `-y` flag accepts the default npm setup.
4. Install [`nodemon`](https://www.npmjs.com/package/nodemon) as a dev dependency:
   ```bash
   npm i -D nodemon
   ```
1. Create the file `nodemon.json` at the root dir of your project and paste this in it:
    ```bash
    {
      "execMap": {
        "R": "Rscript"
      },
      "ext": "*"
    }
    ```
    This specifies an executable mapping for `.R` files: `Rscript`. 
    
    It also tells nodemon to monitor all files (`*`) for changes.
    You can as well monitor specific file extensions. For example to only watch `.R`, `.html`, `.css` & `.js` files, change `ext` to:

    ```bash
    "ext": "R,html,css,js"
    ```
1. Open `package.json` and edit the "scripts" section to this:
    ```bash
    "scripts": {
      "dev": "nodemon --signal SIGTERM server.R"
    }
    ```
   This tells nodemon to re-run the file `server.R` when changes happen.

   The `--signal SIGTERM` is basically telling nodemon to send a termination signal to the previously running program before spawning a new one. This is especially useful for freeing the port the app is running on, and then re-using it again.
1. Run the app:
      ```bash
      npm run dev
      ```
      This runs the `dev` script which starts, stops & restarts your app when changes occurs.

      Now try making some changes to your source code and enjoy the experience.

2. When working on the backend, you don't want a browser tab to open each time the app is restarted since you will mostly be sending requests via postman, so you will set `start(open = FALSE)` in your `server.R`:
    ```R
      library(ambiorix)

      app <- Ambiorix$new()

      app$get("/", \(req, res){
        res$send("Using {ambiorix}!")
      })

      app$get("/about", \(req, res){
        res$text("About")
      })

      app$start(open = FALSE)
    ```
1. To stop npm, press `CTRL` + `C`.
1. Add `node_modules/` to your `.gitignore` file.
2. You can as well add `nodemon.json`, `package-lock.json`, & `package.json` to `.gitignore` since they're just used for development purposes. I have commited them for this example just so you can see their contents.
