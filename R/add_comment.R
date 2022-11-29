#' Add a comment
#'
#' Add a comment to a jira ticket
#'
#' @param comment text of comment. Markdown elements are supported.
#' @author Derek Chiu
#' @export
add_comment <- function(comment) {
  issuekey <- basename(here::here())
  httr::POST(
    url = paste(BASE_URL, issuekey, "comment", sep = "/"),
    config = httr::authenticate(
      user = keyring::key_list(service = "jira")[["username"]],
      password = keyring::key_get(service = "jira")
    ),
    body = list(body = comment),
    encode = "json",
    httr::add_headers("X-Atlassian-Token" = "no-check")
  )
}
