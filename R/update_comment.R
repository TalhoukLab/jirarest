#' Updates a comment
#'
#' Updates a comment on a jira ticket
#'
#' @inheritParams get_comment
#' @inheritParams add_comment
#' @author Derek Chiu
#' @export
update_comment <- function(comment, id, issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  req <-
    auth_req() |>
    httr2::req_url_path_append("issue", issuekey, "comment", id) |>
    httr2::req_body_json(list(body = comment)) |>
    httr2::req_method("PUT")
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  cli::cli_alert_info("Comment ID {.emph {id}} of Issue {issuekey} updated: {.val {resp[['body']]}}")
}
