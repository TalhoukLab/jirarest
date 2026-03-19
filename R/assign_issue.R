#' Assigns an issue to a user
#'
#' Assign an issue to a user for a JIRA ticket
#'
#' @param name username to assign. Set to `NULL` to unassign the issue.
#' @inheritParams get_comment
#' @author Derek Chiu
#' @export
assign_issue <- function(name, issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  req <-
    auth_req() |>
    httr2::req_url_path_append("issue", issuekey, "assignee") |>
    httr2::req_body_json(list(name = name)) |>
    httr2::req_method("PUT")
  resp <- req |>
    httr2::req_perform()
  if (is.null(name)) {
    cli::cli_alert_info("Issue {issuekey} unassigned")
  } else {
    cli::cli_alert_info("Issue {issuekey} assigned to user {.field {name}}")
  }
}
