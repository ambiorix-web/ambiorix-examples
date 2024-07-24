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
  ],
  . / signup_ui[
    create_auth_form_header,
    create_auth_form_footer,
  ],
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
        create_auth_form_header(type = "login"),
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
        create_auth_form_footer(ns = ns, type = "login")
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
