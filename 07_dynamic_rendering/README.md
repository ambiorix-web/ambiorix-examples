## Dynamic rendering

When building software, these are the available options:

1. Build the backend using ambiorix and the frontend using your favorite framework (React, Angular, Vue, etc.)
2. Build the backend and frontend using ambiorix

Let's talk about option 2.

First things first, you will be rendering html templates/files.
In most cases, you want this to be done dynamically. eg. render a portion of the UI depending on whether a user is an admin or not.

This is what is referred to as server-side rendering.

In this example, I use [htmx](https://htmx.org/) to show you how you can build
interactive frontends without touching a single line of JavaScript.

If you know HTML then you're all set!

You've already seen how to send HTTP requests to the server & how the server responds (with JSON so far).

With htmx, your responses from the server will ideally be HTML fragments.

This works so well with [htmltools](https://rstudio.github.io/htmltools/) you will not believe it!
