#' Transition issue to a new status
#'
#' Transition an issue to a new available status. Use [get_issue_transitions()]
#' to discover available transitions.
#'
#' @inheritParams get_comment
#' @param id transition id
#' @author Derek Chiu
#' @export
transition_issue <- function(issue = NULL, id) {
  issuekey <- issue %||% basename(here::here())
  body <- list(transition = list(id = id))
  req <- httr2::request(base_url = paste(BASE_URL, "issue", issuekey, "transitions", sep = "/")) %>%
    rlang::list2(!!!set_auth("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.) %>%
    httr2::req_body_json(body)
  resp <- req %>%
    httr2::req_perform()
}
