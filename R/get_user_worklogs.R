#' Get time spent on all issues for a user
#'
#' The duration of time spent on all issues related to a user within a date
#' range is reported. Both the issues assigned to a user and issues reported by
#' a user but unassigned are included.
#'
#' @inheritParams create_issue
#' @param user username
#' @param from start date of range to consider issues. Defaults to first day
#' of current year
#' @param to end date of range to consider issues. Defaults to current date.
#' @author Derek Chiu
#' @export
get_user_worklogs <- function(user, project = "BC", from = NULL, to = NULL) {
  from <- from %||% paste0(format(Sys.Date(), "%Y"), "-01-01")
  to <- to %||% Sys.Date()

  query <- paste0(
    "project=", project, "&",
    "(assignee=", user, "|(reporter=", user, "&assignee=EMPTY))&",
    "created>=", from, "&",
    "created<=", to
  )
  req <- httr2::request(BASE_URL) %>%
    httr2::req_url_path_append("search") %>%
    httr2::req_url_query(jql = query) %>%
    rlang::list2(!!!set_auth("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.)
  resp <- req %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

  if (length(resp[["issues"]]) == 0) {
    resp %>%
      purrr::pluck("warningMessages") %>%
      purrr::map_chr(~ gsub("value '(.*)'( does.*)", "value {.val \\1}\\2", .)) %>%
      purrr::map_chr(~ gsub("field '(.*)'(\\.)", "field {.field \\1}\\2", .)) %>%
      purrr::walk(cli::cli_alert_warning)
  } else {
    resp %>%
      purrr::pluck("issues") %>%
      purrr::map(~ {
        list(Issue = .[["key"]],
             Time = .[["fields"]][["timespent"]])
      }) %>%
      dplyr::bind_rows() %>%
      dplyr::mutate(Time = lubridate::duration(.data$Time))
  }
}
