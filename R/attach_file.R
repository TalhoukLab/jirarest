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
    auth_req() |>
    httr2::req_url_path_append("issue", issuekey, "attachments") |>
    httr2::req_body_multipart(file = file) |>
    httr2::req_headers(`X-Atlassian-Token` = "no-check")

  # Delete attachment with same file name if already exists
  atts <- get_issue_attachments(issue = issuekey)
  same_att_id <- names(atts[atts %in% basename(file[["path"]])])
  if (length(same_att_id) > 0) {
    delete_attachment(id = same_att_id)
  }

  # Attach file
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()

  # Remove temp file
  if (add_date) {
    unlink(x_temp)
  }
  filename <- basename(file$path)
  cli::cli_alert_info("Attached file {.file {filename}} to Issue {toupper(issuekey)}")

  # Add comment to JIRA issue
  if (comment) {
    add_comment(comment = paste0("Uploaded report {{", filename, "}}"),
                issue = issuekey)
  }
}
