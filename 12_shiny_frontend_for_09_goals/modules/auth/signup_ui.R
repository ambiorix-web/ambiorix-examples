box::use(
  htmltools[tags],
  shiny[
    NS,
    actionLink,
    actionButton
  ],
  .. / .. / store / mod[
    card,
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
    class = "my-2",
    text,
    actionLink(
      inputId = link_input_id,
      label = link_label
    )
  )
}

#' Create auth form submit button
#'
#' @param ns Module namespace from which this function is called.
#' @param type String. Type of form. Either "signup" (default) or "login".
#' @return [htmltools::tags$div()]
#' @export
create_auth_form_btn <- \(
  ns,
  type = c("signup", "login")
) {
  type <- match.arg(arg = type)

  input_id <- ns("signup")
  label <- "Create Account"

  is_login <- identical(type, "login")
  if (is_login) {
    input_id <- ns("login")
    label <- "Login"
  }

  tags$div(
    class = "d-grid",
    actionButton(
      inputId = input_id,
      class = "btn-primary",
      label = label,
      type = "submit"
    )
  )
}

#' Auth form
#'
#' @param ns Module namespace from which this function is called.
#' @param type String. Type of form. Either "signup" (default) or "login".
#' @return [htmltools::tags$form()]
#' @export
auth_form <- \(
  ns,
  type = c("signup", "login")
) {
  type <- match.arg(arg = type)
  is_signup <- identical(type, "signup")

  tags$form(
    create_auth_form_header(type = type),
    if (is_signup) {
      text_input(
        inputId = ns("name"),
        label = "First & Last Name"
      )
    },
    email_input(
      inputId = ns("email"),
      label = "Email"
    ),
    password_input(
      ns = ns,
      input_id = "password",
      label = "Password"
    ),
    create_auth_form_btn(ns = ns, type = type),
    create_auth_form_footer(ns = ns, type = type)
  )
}

#' Create auth page
#'
#' @param ns Namespace of the module from which this function is called.
#' @return [htmltools::tags$div()]
#' @export
create_auth_page <- \(ns, type = c("signup", "login")) {
  type <- match.arg(arg = type)

  tags$div(
    class = "container vh-100 d-flex justify-content-center align-items-center",
    card(
      class = "py-5",
      auth_form(ns = ns, type = type)
    )
  )
}

#' Signup UI module
#'
#' @param id String. Module id.
#' @export
ui <- \(id) {
  ns <- NS(id)
  create_auth_page(ns = ns, type = "signup")
}
