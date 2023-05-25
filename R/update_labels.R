#' Update labels on a jira ticket
#'
#' Update the labels for a jira ticket
#'
#' @inheritParams add_comment
#' @param labels_add labels to add to issue
#' @param labels_remove labels to remove from issue
#' @author Derek Chiu
#' @export
update_labels <- function(labels_add = NULL, labels_remove = NULL, issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  body <- list(update = list(labels = data.frame(
    add = c(labels_add, rep(NA,  length(labels_remove))),
    remove = c(rep(NA, length(labels_add)), labels_remove)
  )))
  res <- httr::PUT(
    url = paste(BASE_URL, issuekey, sep = "/"),
    config = httr::authenticate(
      user = keyring::key_list(service = "jira")[["username"]],
      password = keyring::key_get(service = "jira")
    ),
    body = body,
    encode = "json",
    httr::add_headers("X-Atlassian-Token" = "no-check")
  )
  if (httr::http_error(res)) {
    httr::stop_for_status(res)
  } else {
    cat(
      "Issue",
      issuekey,
      "\nLabels added:",
      stringr::str_flatten_comma(labels_add, last = " and "),
      "\nLabels removed:",
      stringr::str_flatten_comma(labels_remove, last = " and ")
    )
  }
}
