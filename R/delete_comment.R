#' Deletes a comment
#'
#' Delete a comment on a jira ticket
#'
#' @inheritParams get_comment
#' @inheritParams add_comment
#' @author Derek Chiu
#' @export
delete_comment <- function(id, issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  req <-
    auth_req() |>
    httr2::req_url_path_append("issue", issuekey, "comment", id) |>
    httr2::req_method("DELETE")
  resp <- req |>
    httr2::req_perform()
  cli::cli_alert_info("Comment ID {.emph {id}} of Issue {issuekey} deleted")
}
