% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/create_issue.R
\name{create_issue}
\alias{create_issue}
\title{Create an issue}
\usage{
create_issue(project, summary, description, issuetype = "Task")
}
\arguments{
\item{project}{jira project name}

\item{summary}{summary of the issue}

\item{description}{more detailed description of the issue}

\item{issuetype}{issue type, i.e. "Task", "Bug", "Improvement", etc.}
}
\description{
Create a new issue within a project.
}
\author{
Derek Chiu
}
