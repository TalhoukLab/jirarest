# Returns all date fields for an issue

A data frame of date created, date updated, and date resolved (if
applicable) for an issue

## Usage

``` r
get_issue_dates(issue = NULL)
```

## Arguments

- issue:

  the issue key. Defaults to the project directory base name, assuming
  the R project is named after the issue key.

## Author

Derek Chiu
