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
  res <- httr::POST(
    url = paste(BASE_URL, issuekey, "comment", sep = "/"),
    config = set_auth("jira"),
    body = list(body = comment),
    encode = "json",
    httr::add_headers("X-Atlassian-Token" = "no-check")
  )
  if (httr::http_error(res)) {
    httr::stop_for_status(res)
  } else {
    paste0("New comment added for Issue ",
           issuekey,
           ": ",
           httr::content(res)[["body"]])
  }
}
