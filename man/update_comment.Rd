% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/update_comment.R
\name{update_comment}
\alias{update_comment}
\title{Updates a comment}
\usage{
update_comment(comment, id, issue = NULL)
}
\arguments{
\item{comment}{text of comment. Markdown elements are supported.}

\item{id}{the ID of the comment}

\item{issue}{the issue key. Defaults to the project directory base name,
assuming the R project is named after the issue key.}
}
\description{
Updates a comment on a jira ticket
}
\author{
Derek Chiu
}
