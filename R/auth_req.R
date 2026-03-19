#' Create an authenticated request
#'
#' Create an authenticated request with stored username and password
#'
#' @export
auth_req <- function() {
  auth <- set_auth("jira")
  username <- auth[["username"]]
  password <- auth[["password"]]
  httr2::request(base_url = BASE_URL) |>
    httr2::req_auth_basic(username = username, password = password)
}
