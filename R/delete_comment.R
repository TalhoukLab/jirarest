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
    httr2::request(base_url = paste(BASE_URL, "issue", issuekey, "comment", id, sep = "/")) %>%
    rlang::list2(!!!set_auth("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.) %>%
    httr2::req_method("DELETE")
  resp <- req %>%
    httr2::req_perform()
  cli::cli_alert_info("Comment ID {.emph {id}} of Issue {issuekey} deleted")
}
