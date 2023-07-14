#' Returns the total time spent on an issue
#'
#' The individual worklogs are added up and displayed in a human-friendly
#' duration format.
#'
#' @inheritParams get_comment
#' @author Derek Chiu
#' @export
get_issue_worklogs <- function(issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  req <-
    httr2::request(base_url = paste(BASE_URL, "issue", issuekey, "worklog", sep = "/")) %>%
    rlang::list2(!!!set_auth("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.)
  resp <- req %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()
  dur <- resp %>%
    purrr::pluck("worklogs") %>%
    purrr::map_int("timeSpentSeconds") %>%
    sum() %>%
    lubridate::duration(units = "seconds")
  cli::cli_alert_info("Time logged for {issuekey}: {dur}")
}
