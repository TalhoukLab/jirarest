#' Returns all transitions that can be applied to an issue
#'
#' A data frame of available transitions to apply to an issue and their ids. The
#' available transitions change depending on the current issue status.
#'
#' @inheritParams get_comment
#' @author Derek Chiu
#' @export
get_issue_transitions <- function(issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  req <- httr2::request(base_url = paste(BASE_URL, "issue", issuekey, "transitions", sep = "/")) %>%
    rlang::list2(!!!set_auth("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.)
  resp <- req %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()
  resp[["transitions"]] %>%
    purrr::map(~ {
      list(id = .[["id"]],
           name = .[["name"]])
    }) %>%
    dplyr::bind_rows()
}
