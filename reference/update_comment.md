# Updates a comment

Updates a comment on a jira ticket

## Usage

``` r
update_comment(comment, id, issue = NULL)
```

## Arguments

- comment:

  text of comment. Markdown elements are supported.

- id:

  the ID of the comment

- issue:

  the issue key. Defaults to the project directory base name, assuming
  the R project is named after the issue key.

## Author

Derek Chiu
