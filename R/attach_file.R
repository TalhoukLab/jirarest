#' Attach a file
#'
#' Attach a file to a jira ticket
#'
#' @param x path to file to attach
#' @param add_date if `TRUE`, appends today's date to the attached file name
#' @inheritParams add_comment
#' @author Derek Chiu
#' @export
attach_file <- function(x, issue = NULL, add_date = FALSE) {
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
    file <- httr::upload_file(x_temp)
  } else {
    file <- httr::upload_file(x)
  }

  # POST output as file attachment to jira ticket
  issuekey <- issue %||% basename(here::here())
  res <- httr::POST(
    url = paste(BASE_URL, issuekey, "attachments", sep = "/"),
    config = httr::authenticate(
      user = keyring::key_list(service = "jira")[["username"]],
      password = keyring::key_get(service = "jira")
    ),
    body = list(file = file),
    httr::add_headers("X-Atlassian-Token" = "no-check")
  )

  # Remove temp file
  if (add_date) {
    unlink(x_temp)
  }
}
