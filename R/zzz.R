.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Please run `store_auth(username)` to ensure Jira credentials are stored.")
}
