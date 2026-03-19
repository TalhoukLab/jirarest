#' Returns reporter for an issue
#'
#' Returns the user who created the issue
#'
#' @inheritParams get_comment
#' @author Derek Chiu
#' @export
get_issue_reporter <- function(issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  req <-
    httr2::request(base_url = paste(BASE_URL, "issue", issuekey, sep = "/")) %>%
    rlang::list2(!!!set_auth("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.)
  resp <- req %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()
  purrr::pluck(resp, "fields", "reporter", "displayName")
}
