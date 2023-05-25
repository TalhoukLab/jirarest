#' Updates a comment
#'
#' Updates a comment on a jira ticket
#'
#' @inheritParams get_comment
#' @inheritParams add_comment
#' @author Derek Chiu
#' @export
update_comment <- function(comment, id, issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  res <- httr::PUT(
    url = paste(BASE_URL, "issue", issuekey, "comment", id, sep = "/"),
    config = set_auth("jira"),
    body = list(body = comment),
    encode = "json",
    httr::add_headers("X-Atlassian-Token" = "no-check")
  )
  if (httr::http_error(res)) {
    httr::stop_for_status(res)
  } else {
    paste0("Comment ID ",
           id,
           " of Issue ",
           issuekey,
           " updated with text: ",
           httr::content(res)[["body"]])
  }
}
