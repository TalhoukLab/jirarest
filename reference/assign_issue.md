# Assigns an issue to a user

Assign an issue to a user for a JIRA ticket

## Usage

``` r
assign_issue(name, issue = NULL)
```

## Arguments

- name:

  username to assign. Set to `NULL` to unassign the issue.

- issue:

  the issue key. Defaults to the project directory base name, assuming
  the R project is named after the issue key.

## Author

Derek Chiu
