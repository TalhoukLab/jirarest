# Store JIRA credentials to authenticate with OpenSpecimen API

Store JIRA credentials in system credential store.

## Usage

``` r
store_auth(username)
```

## Arguments

- username:

  jira username

## Details

Stores JIRA username and password in your system's credential store.
Authentication for all RESTful API calls to OpenSpecimen persist for the
same R session.

## Author

Derek Chiu
