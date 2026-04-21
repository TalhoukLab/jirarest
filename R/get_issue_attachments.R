#' Returns all attachments for an issue
#'
#' A list of file names for all attachments for an issue. Attachment IDs
#' are used as the list names.
#'
#' @inheritParams get_comment
#' @author Derek Chiu
#' @export
get_issue_attachments <- function(issue = NULL) {
  issuekey <- issue %||% basename(here::here())
  req <-
    auth_req() |>
    httr2::req_url_path_append("issue", issuekey)
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  resp[["fields"]] |>
    purrr::pluck("attachment") |>
    purrr::map(`[`, c("id", "filename")) |>
    purrr::transpose() |>
    tibble::deframe()
}
