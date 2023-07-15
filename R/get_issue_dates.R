#' Returns all date fields for an issue
#'
#' A data frame of date created, date updated, and date resolved (if applicable)
#' for an issue
#'
#' @inheritParams get_comment
#' @author Derek Chiu
#' @export
get_issue_dates <- function(issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  req <-
    httr2::request(base_url = paste(BASE_URL, "issue", issuekey, sep = "/")) %>%
    rlang::list2(!!!set_auth("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.)
  resp <- req %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()
  resp[["fields"]] %>%
    `[`(c("created", "updated", "resolutiondate")) %>%
    purrr::map(as.POSIXct, format = "%Y-%m-%dT%H:%M:%OS") %>%
    dplyr::bind_cols()
}
