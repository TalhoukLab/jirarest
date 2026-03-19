# Attach a file

Attach a file to a jira ticket

## Usage

``` r
attach_file(x, issue = NULL, add_date = FALSE, comment = TRUE)
```

## Arguments

- x:

  path to file to attach

- issue:

  the issue key. Defaults to the project directory base name, assuming
  the R project is named after the issue key.

- add_date:

  if `TRUE`, appends today's date to the attached file name

- comment:

  if `TRUE` (default), add a comment to the issue detailing full name of
  attached file

## Author

Derek Chiu
