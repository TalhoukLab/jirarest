#' Returns linked issues to an Epic
#'
#' Return all linked issues to an Epic issue.
#'
#' @inheritParams get_comment
#' @author Derek Chiu
#' @export
get_epic_linked_issues <- function(issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  res <- httr::GET(
    url = paste0(BASE_URL, "/search?jql='Epic Link'=", issuekey),
    config = set_auth("jira"),
    encode = "json",
    httr::add_headers("X-Atlassian-Token" = "no-check")
  )
  cont <- httr::content(res)
  linked_issues <- sort(purrr::map_chr(cont[["issues"]], "key"))
  linked_issues
}
