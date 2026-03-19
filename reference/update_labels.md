# Update labels on a jira ticket

Update the labels for a jira ticket

## Usage

``` r
update_labels(labels_add = NULL, labels_remove = NULL, issue = NULL)
```

## Arguments

- labels_add:

  labels to add to issue

- labels_remove:

  labels to remove from issue

- issue:

  the issue key. Defaults to the project directory base name, assuming
  the R project is named after the issue key.

## Author

Derek Chiu
