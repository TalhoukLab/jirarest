
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jirarest

<!-- badges: start -->

[![R-CMD-check](https://github.com/TalhoukLab/jirarest/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/TalhoukLab/jirarest/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of jirarest is to provide a REST API in R for accessing the
BCGSC Jira ticketing system.

## Installation

You can install the development version of jirarest from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("TalhoukLab/jirarest")
```

## Examples

Here are examples of the currently implemented resources.

### Create Issue

An issue can be created within a Jira project.

``` r
library(jirarest)
create_issue(project = "BC",
             summary = "new analysis",
             description = "analysis for someone")
```

### Add Comment

We can add comments to existing issues. Assumes that the current working
directory is the name of issue.

``` r
add_comment("report completed")
```

### Attach File

Files such as PDF reports and data can be attached to issues.

``` r
attach_file("/path/to/file")
```
