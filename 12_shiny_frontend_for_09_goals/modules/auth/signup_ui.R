box::use(
  htmltools[tags],
  shiny[
    NS,
    actionLink,
    actionButton
  ],
  .. / .. / store / mod[
    text_input,
    email_input,
    password_input,
  ]
)

#' Create auth form header
#'
#' @param type String. Type of form. Either "signup" (default) or "login".
#' @return [htmltools::tags$div()]
#' @export
create_auth_form_header <- \(type = c("signup", "login")) {
  type <- match.arg(arg = type)

  title <- "Create an Account"
  subtitle <- "Enter your details to create an account"

  is_login <- identical(type, "login")
  if (is_login) {
    title <- "Login to your account"
    subtitle <- "Enter your email & password to login"
  }

  tags$div(
    class = "text-center",
    tags$h4(title),
    tags$p(subtitle)
  )
}

#' Sign up page
#'
#' @param ns Namespace of the module from which this function is called.
#' @return [htmltools::tags$div()]
#' @export
page <- \(ns) {
  tags$div(
    class = "container vh-100 d-flex justify-content-center align-items-center",
    tags$div(
      tags$form(
        create_auth_form_header(type = "signup"),
        text_input(
          inputId = ns("name"),
          label = "First & Last Name"
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
            inputId = ns("signup"),
            label = "Create Account",
            type = "submit"
          )
        ),
        tags$p(
          "Already have an account?",
          actionLink(
            inputId = ns("login"),
            "Log in"
          )
        )
      )
    )
  )
}

#' Signup UI module
#'
#' @param id String. Module id.
#' @export
ui <- \(id) {
  ns <- NS(id)
  page(ns)
}
