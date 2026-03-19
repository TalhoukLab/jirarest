# Returns all transitions that can be applied to an issue

A data frame of available transitions to apply to an issue and their
ids. The available transitions change depending on the current issue
status.

## Usage

``` r
get_issue_transitions(issue = NULL)
```

## Arguments

- issue:

  the issue key. Defaults to the project directory base name, assuming
  the R project is named after the issue key.

## Author

Derek Chiu
