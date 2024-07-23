box::use(
  htmltools[tags],
  shiny[
    NS,
    actionLink,
    actionButton
  ],
  .. / .. / store / mod[
    email_input,
    password_input,
  ]
)

#' Sign up page
#'
#' @param ns Namespace of the module from which this function is called.
#' @return [htmltools::tags()]
#' @export
page <- \(ns) {
  tags$div(
    class = "container vh-100 d-flex justify-content-center align-items-center",
    tags$div(
      tags$form(
        tags$div(
          class = "text-center",
          tags$h4("Login to your account"),
          tags$p("Enter your email & password to login"),
        ),
        email_input(
          inputId = ns("email"),
          label = "Email"
        ),
        password_input(
          ns = ns,
          input_id = "password",
          label = "Password"
        ),
        tags$div(
          class = "d-grid",
          actionButton(
            inputId = ns("login"),
            label = "Login",
            type = "submit"
          )
        ),
        tags$p(
          "Don't have an account?",
          actionLink(
            inputId = ns("signup"),
            "Create an account"
          )
        )
      )
    )
  )
}

#' Login UI module
#'
#' @param id String. Module id.
#' @export
ui <- \(id) {
  ns <- NS(id)
  page(ns)
}
