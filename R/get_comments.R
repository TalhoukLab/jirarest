#' Returns a comment
#'
#' Return all comments for an issue
#'
#' @param issue the issue key. Defaults to the project directory base name,
#'   assuming the R project is named after the issue key.
#' @param escape if `TRUE`, line returns are escaped for improved formatting of
#'   comments
#' @author Derek Chiu
#' @export
get_comments <- function(issue = NULL, escape = FALSE) {
  issuekey <- issue %||% basename(here::here())
  req <-
    auth_req() |>
    httr2::req_url_path_append("issue", issuekey, "comment")
  resp <- req |>
    httr2::req_perform() |>
    httr2::resp_body_json()
  results <- resp[["comments"]]
  comments <- purrr::map(results, "body")
  ids <- purrr::map(results, "id")
  comments <- stats::setNames(comments, ids)

  if (escape) {
    purrr::iwalk(comments, ~ {
      cat("Comment ID: ", .y, "\n", .x)
    })
  } else {
    comments
  }
}
