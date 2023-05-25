#' Store JIRA credentials to authenticate with OpenSpecimen API
#'
#' Store JIRA credentials in system credential store.
#'
#' Stores JIRA username and password in your system's credential store.
#' Authentication for all RESTful API calls to OpenSpecimen persist for the same
#' R session.
#'
#' @param username jira username
#' @author Derek Chiu
#' @export
store_auth <- function(username) {
  keyring::key_set(service = "jira", username = username)
}
