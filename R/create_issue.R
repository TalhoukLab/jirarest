#' Create an issue
#'
#' Create a new issue within a project.
#'
#' @param project jira project name
#' @param summary summary of the issue
#' @param description more detailed description of the issue
#' @param issuetype issue type, i.e. "Task", "Bug", "Improvement", etc.
#' @author Derek Chiu
#' @export
create_issue <- function(project, summary, description, issuetype = "Task") {
  req <-
    auth_req() |>
    httr2::req_url_path_append("issue") |>
    httr2::req_body_json(list(
      fields = list(
        project = list(key = project),
        summary = summary,
        description = description,
        issuetype = list(name = issuetype)
      )
    ))
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  cli::cli_alert_info("Issue {resp[['key']]} created")
}
