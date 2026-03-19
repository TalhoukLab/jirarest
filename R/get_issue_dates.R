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
    auth_req() |>
    httr2::req_url_path_append("issue", issuekey)
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  resp[["fields"]] |>
    purrr::keep_at(c("created", "updated", "resolutiondate")) |>
    purrr::map(~ ifelse(is.null(.x), "", .x)) |>
    purrr::map(as.POSIXct, format = "%Y-%m-%dT%H:%M:%OS") |>
    dplyr::bind_cols() |>
    dplyr::relocate(resolved = "resolutiondate", .after = 3)
}
