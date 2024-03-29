% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_issue_dates.R
\name{get_issue_dates}
\alias{get_issue_dates}
\title{Returns all date fields for an issue}
\usage{
get_issue_dates(issue = NULL)
}
\arguments{
\item{issue}{the issue key. Defaults to the project directory base name,
assuming the R project is named after the issue key.}
}
\description{
A data frame of date created, date updated, and date resolved (if applicable)
for an issue
}
\author{
Derek Chiu
}
