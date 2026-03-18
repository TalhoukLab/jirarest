#' Returns a comment
#'
#' Return all comments for an issue
#'
#' @param issue the issue key. Defaults to the project directory base name,
#'   assuming the R project is named after the issue key.
#' @author Derek Chiu
#' @export
get_comments <- function(issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  req <-
    httr2::request(base_url = paste(BASE_URL, "issue", issuekey, "comment", sep = "/")) %>%
    rlang::list2(!!!set_auth("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.)
  resp <- req %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()
  resp |>
    purrr::pluck("comments") |>
    purrr::map("body")
}
