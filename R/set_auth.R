#' Set configuration settings for JIRA authentication
#' @noRd
set_auth <- function(service = "jira") {
  key <- keyring::key_list(service = service)
  if (nrow(key) == 0) {
    stop(
      paste0(
        "JIRA credentials not stored in service ",
        dQuote(service),
        ". Run `authenticate_jira(username)`."
      )
    )
  }
  username <- key[["username"]]
  password <- keyring::key_get(service = service, username = username)
  invisible(list(username = username, password = password))
}
