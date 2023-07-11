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
    httr2::request(base_url = paste(BASE_URL, "issue", issuekey, "comment", id, sep = "/")) %>%
    rlang::list2(!!!set_auth("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.) %>%
    httr2::req_body_json(list(body = comment)) %>%
    httr2::req_method("PUT")
  resp <- req %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()
  cli::cli_alert_info("Comment ID {.emph {id}} of Issue {issuekey} updated: {.val {resp[['body']]}}")
}
