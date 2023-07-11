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
  req <-
    httr2::request(base_url = paste(BASE_URL, "issue", issuekey, sep = "/")) %>%
    rlang::list2(!!!set_auth("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.) %>%
    httr2::req_body_json(body) %>%
    httr2::req_method("PUT")
  resp <- req %>%
    httr2::req_perform()
  cli::cli_rule("Issue {issuekey}")
  cli::cli_alert_info("{.dt Labels added}{.dd {labels_add}}")
  cli::cli_alert_info("{.dt Labels removed}{.dd {labels_remove}}")
}
