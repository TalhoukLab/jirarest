# Returns a comment

Return a single comment of a jira ticket

## Usage

``` r
get_comment(id, issue = NULL, escape = FALSE)
```

## Arguments

- id:

  the ID of the comment

- issue:

  the issue key. Defaults to the project directory base name, assuming
  the R project is named after the issue key.

- escape:

  if `TRUE`, line returns are escaped for improved formatting of
  comments

## Author

Derek Chiu
