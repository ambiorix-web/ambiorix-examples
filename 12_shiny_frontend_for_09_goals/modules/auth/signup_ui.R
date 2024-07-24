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

#' Create auth form footer
#'
#' @param ns Module namespace from where this function is called.
#' @param type String. Type of form. Either "signup" (default) or "login".
#' @return [htmltools::tags$p()]
#' @export
create_auth_form_footer <- \(
  ns,
  type = c("signup", "login")
) {
  type <- match.arg(arg = type)

  text <- "Already have an account?"
  link_label <- "Log in"
  link_input_id <- ns("login")

  is_login <- identical(type, "login")
  if (is_login) {
    text <- "Don't have an account?"
    link_label <- "Create an account"
    link_input_id <- ns("signup")
  }

  tags$p(
    text,
    actionLink(
      inputId = link_input_id,
      label = link_label
    )
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
        create_auth_form_footer(ns = ns, type = "signup")
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
