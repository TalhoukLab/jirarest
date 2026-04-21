# Returns all attachments for an issue

A list of file names for all attachments for an issue. Attachment IDs
are used as the list names.

## Usage

``` r
get_issue_attachments(issue = NULL)
```

## Arguments

- issue:

  the issue key. Defaults to the project directory base name, assuming
  the R project is named after the issue key.

## Author

Derek Chiu
