#' Returns linked issues to an Epic
#'
#' Return all linked issues to an Epic issue.
#'
#' @inheritParams get_comment
#' @author Derek Chiu
#' @export
get_epic_linked_issues <- function(issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  req <-
    auth_req() |>
    httr2::req_url_path_append("search") |>
    httr2::req_url_query(jql = paste0("'Epic Link'=", issuekey))
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  linked_issues <-
    sort(vapply(resp[["issues"]], \(x) x[["key"]], character(1)))
  linked_issues
}
