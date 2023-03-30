#' Assigns an issue to a user
#'
#' Assign an issue to a user for a JIRA ticket
#'
#' @param name username to assign
#' @inheritParams get_comment
#' @author Derek Chiu
#' @export
assign_issue <- function(name, issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  res <- httr::PUT(
    url = paste(BASE_URL, issuekey, "assignee", sep = "/"),
    config = set_auth("jira"),
    body = list(name = name),
    encode = "json",
    httr::add_headers("X-Atlassian-Token" = "no-check")
  )
  if (httr::http_error(res)) {
    httr::stop_for_status(res)
  } else {
    paste0("Issue ", issue, " assigned to user ", name)
  }
}
