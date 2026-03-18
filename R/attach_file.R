#' Attach a file
#'
#' Attach a file to a jira ticket
#'
#' @param x path to file to attach
#' @param add_date if `TRUE`, appends today's date to the attached file name
#' @param comment if `TRUE` (default), add a comment to the issue detailing
#'  full name of attached file
#' @inheritParams add_comment
#' @author Derek Chiu
#' @export
attach_file <- function(x, issue = NULL, add_date = FALSE, comment = TRUE) {
  # Add today's date to file name by copying output to temporary directory
  if (add_date) {
    base_name <- basename(x)
    x_temp <- file.path(
      tempdir(),
      paste0(
        tools::file_path_sans_ext(base_name),
        "_",
        Sys.Date(),
        ".",
        tools::file_ext(base_name)
      )
    )
    file.copy(x, x_temp)
    file <- curl::form_file(x_temp)
  } else {
    file <- curl::form_file(x)
  }

  # POST output as file attachment to jira ticket
  issuekey <- issue %||% basename(here::here())
  req <-
    httr2::request(base_url = paste(BASE_URL, "issue", issuekey, "attachments", sep = "/")) %>%
    rlang::list2(!!!set_auth("jira")) %>%
    rlang::exec(httr2::req_auth_basic, !!!.) %>%
    httr2::req_body_multipart(file = file) %>%
    httr2::req_headers(`X-Atlassian-Token` = "no-check")
  resp <- req %>%
    httr2::req_perform() %>%
    httr2::resp_body_json()

  # Remove temp file
  if (add_date) {
    unlink(x_temp)
  }
  cli::cli_alert_info("Attached file {.file {x}} to Issue {toupper(issuekey)}")

  # Add comment to JIRA issue
  if (comment) {
    resp |>
      purrr::pluck(1, "filename") |>
      paste0("Uploaded report {{", ... = _, "}}") |>
      add_comment()
  }
}
