#' Generate roxygen2 documentation during package build
#'
#' Add a call to this function to any file in your \code{R} directory.
#' Use explicit qualification (like \code{autoroxy::autoroxy()}) to avoid
#' importing the package and its dependencies.
#' @export
autoroxy <- function() {
  if ("DESCRIPTION" %in% dir()) {
    message("*** autoroxy: creating documentation")
    roxygen2::roxygenize(roclets = c("rd", "collate"))
  }
}
