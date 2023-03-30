#' Returns a comment
#'
#' Return a single comment of a jira ticket
#'
#' @param id the ID of the comment
#' @param issue the issue key. Defaults to the project directory base name,
#'   assuming the R project is named after the issue key.
#' @author Derek Chiu
#' @export
get_comment <- function(id, issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  res <- httr::GET(
    url = paste(BASE_URL, issuekey, "comment", id, sep = "/"),
    config = set_auth("jira"),
    encode = "json",
    httr::add_headers("X-Atlassian-Token" = "no-check")
  )
  if (httr::http_error(res)) {
    httr::stop_for_status(res)
  } else {
    httr::content(res)[["body"]]
  }
}
