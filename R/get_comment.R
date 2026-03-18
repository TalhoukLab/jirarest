#' Returns a comment
#'
#' Return a single comment of a jira ticket
#'
#' @param id the ID of the comment
#' @inheritParams get_comments
#' @author Derek Chiu
#' @export
get_comment <- function(id, issue = NULL, escape = FALSE) {
  issuekey <- issue %||% basename(here::here())
  req <-
    httr2::request(base_url = paste(BASE_URL, "issue", issuekey, "comment", id, sep = "/")) %>%
    rlang::list2(!!!set_auth("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.)
  resp <- req %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()
  resp[["body"]]
}
