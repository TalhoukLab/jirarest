# Returns a comment

Return all comments for an issue

## Usage

``` r
get_comments(issue = NULL, escape = FALSE)
```

## Arguments

- issue:

  the issue key. Defaults to the project directory base name, assuming
  the R project is named after the issue key.

- escape:

  if `TRUE`, line returns are escaped for improved formatting of
  comments

## Author

Derek Chiu
