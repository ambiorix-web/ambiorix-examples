box::use(
  htmltools[tags],
  shiny[
    NS,
    actionButton
  ],
  .. / .. / store / mod[
    text_input,
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
          tags$h4("Create an Account"),
          tags$p("Enter your details to create an account"),
        ),
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
