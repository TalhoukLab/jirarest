#' Get time spent on issues with specified labels
#'
#' The duration of time spent on all issues related to a set of labels within a
#' date range is reported.
#'
#' @inheritParams create_issue
#' @param labels vector of labels
#' @param from start date of range to consider issues. Defaults to first day
#' of current year
#' @param to end date of range to consider issues. Defaults to current date.
#' @param maxResults maximum number of results to return. Defaults to 50.
#' @author Derek Chiu
#' @export
get_label_worklogs <- function(labels, project = "BC", from = NULL, to = NULL,
                               maxResults = 50) {
  from <- from %||% paste0(format(Sys.Date(), "%Y"), "-01-01")
  to <- to %||% Sys.Date()

  jql <- paste0(
    "project=", project, "&",
    "labels in (", paste(labels, collapse = ", "), ")&",
    "created>=", from, "&",
    "created<=", to
  )
  req <- httr2::request(BASE_URL) %>%
    httr2::req_url_path_append("search") %>%
    httr2::req_url_query(maxResults = maxResults) %>%
    httr2::req_url_query(jql = jql) %>%
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
    if (resp[["total"]] > resp[["maxResults"]]) {
      cli::cli_alert_warning(c(resp[["maxResults"]], " results returned out of a total of ",
                               resp[["total"]], ". Consider increasing {.code maxResults}."))
    }
    resp %>%
      purrr::pluck("issues") %>%
      purrr::map(~ {
        list(
          Issue = .[["key"]],
          Labels = paste(.[["fields"]][["labels"]], collapse = ", "),
          Time = ifelse(is.null(.[["fields"]][["timespent"]]),
                        NA_integer_,
                        .[["fields"]][["timespent"]])
        )
      }) %>%
      dplyr::bind_rows() %>%
      dplyr::mutate(Time = lubridate::duration(.data$Time))
  }
}
