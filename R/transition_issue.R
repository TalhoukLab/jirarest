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
  req <-
    auth_req() |>
    httr2::req_url_path_append("issue", issuekey, "transitions") |>
    httr2::req_body_json(body)
  resp <- req |>
    httr2::req_perform()
}
