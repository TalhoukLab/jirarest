# Transition issue to a new status

Transition an issue to a new available status. Use
[`get_issue_transitions()`](https://talhouklab.github.io/jirarest/reference/get_issue_transitions.md)
to discover available transitions.

## Usage

``` r
transition_issue(issue = NULL, id)
```

## Arguments

- issue:

  the issue key. Defaults to the project directory base name, assuming
  the R project is named after the issue key.

- id:

  transition id

## Author

Derek Chiu
