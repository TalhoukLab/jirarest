#' Add a comment
#'
#' Add a comment to a jira ticket
#'
#' @param comment text of comment. Markdown elements are supported.
#' @param issue the issue key. Defaults to the project directory base name,
#'   assuming the R project is named after the issue key.
#' @author Derek Chiu
#' @export
add_comment <- function(comment, issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  req <-
    httr2::request(base_url = paste(BASE_URL, "issue", issuekey, "comment", sep = "/")) %>%
    rlang::list2(!!!set_auth2("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.) %>%
    httr2::req_body_json(list(body = comment))
  resp <- req %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()
  cli::cli_alert_info("New comment added for Issue {issuekey}: {resp[['body']]}")
}
