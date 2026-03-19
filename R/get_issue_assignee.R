#' Returns assignee for an issue
#'
#' Returns the user designated as the assignee for an issue
#'
#' @inheritParams get_comment
#' @author Derek Chiu
#' @export
get_issue_assignee <- function(issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  req <-
    auth_req() |>
    httr2::req_url_path_append("issue", issuekey)
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  assignee <- purrr::pluck(resp, "fields", "assignee", "displayName")
  if (is.null(assignee)) "Unassigned" else assignee
}
