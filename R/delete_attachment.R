#' Deletes an attachment
#'
#' Deletes an attachment from an issue
#'
#' The issue ID is actually not needed, only the attachment ID.
#'
#' @inheritParams get_comment
#' @author Derek Chiu
#' @export
delete_attachment <- function(id) {
  req <-
    auth_req() |>
    httr2::req_url_path_append("attachment", id) |>
    httr2::req_method("DELETE")
  resp <- req |>
    httr2::req_perform()
  cli::cli_alert_info("Attachment ID {.emph {id}} deleted")
}
