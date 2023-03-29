#' Authenticate JIRA credentials
#'
#' Store JIRA credentials in system credential store.
#'
#' Stores JIRA username and password in your system's credential store.
#' Authentication for all RESTful API calls persist for the same R session.
#'
#' @param username jira username
#' @author Derek Chiu
#' @export
authenticate_jira <- function(username) {
  keyring::key_set("jira", username = username)
}
