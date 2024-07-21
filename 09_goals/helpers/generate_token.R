box::use(
  jose[jwt_claim, jwt_encode_hmac],
  lubridate[now],
  . / get_jwt_secret[get_jwt_secret]
)

#' Generate JWT
#'
#' @param user_id User id
#' @param expires_in How long before the token expires. Defaults to 1 month.
#' @export
generate_token <- \(
  user_id,
  expires_in = now("UTC") + months(1, abbreviate = FALSE)
) {
  jwt_encode_hmac(
    claim = jwt_claim(
      exp = expires_in,
      user_id = user_id
    ),
    secret = get_jwt_secret()
  )
}
