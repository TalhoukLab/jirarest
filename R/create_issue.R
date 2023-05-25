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
  res <- httr::POST(
    url = paste(BASE_URL, "issue", sep = "/"),
    config = set_auth("jira"),
    body = list(fields = list(
      project = list(
        key = project
      ),
      summary = summary,
      description = description,
      issuetype = list(
        name = issuetype
      )
    )),
    encode = "json",
    httr::add_headers("X-Atlassian-Token" = "no-check",
                      "Content-Type" = "application/json")
  )
}
