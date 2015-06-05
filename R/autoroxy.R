#' Generate roxygen2 documentation during package build
#'
#' Add a call to this function to any file in your \code{R} directory.
autoroxy <- function() {
  if ("DESCRIPTION" %in% dir()) {
    message("*** autoroxy: creating documentation")
    roxygen2::roxygenize()
  }
}
