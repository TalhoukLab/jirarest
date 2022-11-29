.onAttach <- function(libname, pkgname) {
  packageStartupMessage("Please run `authenticate_jira(username)` to ensure Jira credentials are stored.")
}
