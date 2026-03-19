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
    auth_req() |>
    httr2::req_url_path_append("issue", issuekey)
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  purrr::pluck(resp, "fields", "reporter", "displayName")
}
