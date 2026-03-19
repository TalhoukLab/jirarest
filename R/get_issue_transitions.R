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
  req <-
    auth_req() |>
    httr2::req_url_path_append("issue", issuekey, "transitions")
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  resp[["transitions"]] |>
    purrr::map(~ purrr::keep_at(.x, c("id", "name"))) |>
    dplyr::bind_rows()
}
