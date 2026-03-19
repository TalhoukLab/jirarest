# Get time spent on issues with specified labels

The duration of time spent on all issues related to a set of labels
within a date range is reported.

## Usage

``` r
get_label_worklogs(
  labels,
  project = "BC",
  from = NULL,
  to = NULL,
  maxResults = 50
)
```

## Arguments

- labels:

  vector of labels

- project:

  jira project name

- from:

  start date of range to consider issues. Defaults to first day of
  current year

- to:

  end date of range to consider issues. Defaults to current date.

- maxResults:

  maximum number of results to return. Defaults to 50.

## Author

Derek Chiu
