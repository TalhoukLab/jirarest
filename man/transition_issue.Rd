% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/transition_issue.R
\name{transition_issue}
\alias{transition_issue}
\title{Transition issue to a new status}
\usage{
transition_issue(issue = NULL, id)
}
\arguments{
\item{issue}{the issue key. Defaults to the project directory base name,
assuming the R project is named after the issue key.}

\item{id}{transition id}
}
\description{
Transition an issue to a new available status. Use \code{\link[=get_issue_transitions]{get_issue_transitions()}}
to discover available transitions.
}
\author{
Derek Chiu
}
