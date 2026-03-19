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
    auth_req() |>
    httr2::req_url_path_append("issue", issuekey, "comment", id)
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  resp[["body"]]
}
