#' Turn version-controlled documentation on and off
#'
#' Documentation, if generated automatically by, e.g., \code{roxygen2},
#' is a build artifact that ideally should not be added to a version
#' control system.  On the other hand, it seems necessary to
#' version-control the documentation:
#' \itemize{
#'   \item direct installation (via R CMD \code{\link[base]{INSTALL}} and others)
#'     and building a source archive
#'     requires fully built documentation
#'   \item the generated documentation depends not only on the package
#'     itself, but also on \code{roxygen2} and perhaps
#'     other packages that are used in the generation process.
#' }
#' These functions attempt to work around this
#' dilemma.
#'
#' It is assumed that Git is used to version-control the package.
#' The functions switch between two states: ignoring and versioning
#' documentation.
#' (This affects only the \code{man} directory, the \code{NAMESPACE}
#' and \code{DESCRIPTION} files are always version-controlled.)
#' Currently, this is an all-or-nothing decision:
#' It is not possible to keep only selected files version-controlled.
#'
#' The Git repository must be in a clean state, i.e., the command
#' \code{git status} shows no changes.
#' On success, the changes are committed to Git.
#' Repeatedly calling the same function twice should have no effect on the
#' second call.
#'
#' Repeatedly turning documentation on an off in the same branch
#' clutters the history.  Hence, it is recommended to perform
#' development in a dedicated development branch and keep the
#' documentation only in a dedicated release branch.  This is achieved
#' easily by using \code{git flow} -- documentation can be turned
#' off in the \code{develop} branch (and hence all feature branches),
#' turned on again as soon as a release is started, and turned off
#' after merging a released version back to \code{develop}.
#' Hooks can help automating this process.
#' As the history in the \code{master} branch contains
#' only merges from release branches, even repeated turning off and on
#' of documentation in development branches doesn't show in the mainline
#' history of \code{master}.  Remember to run at least
#' \code{git diff --name-status master..} before finishing a release.
#'
#' @importFrom devtools as.package document
#' @export
#' @name rox
#' @aliases rox_on
rox_on <- function(pkg = ".") {
  pkg <- as.package(pkg)
  repo <- git2r::repository(pkg$path)

  check_git_clean(repo)
  gitignore(repo, add = FALSE)
  add_documentation(pkg, repo)
  remove_autoroxy(pkg, repo)
  remove_autoroxy_dep(pkg, repo)
  dirty_commit(repo, "rox_on: documentation is version-controlled")
}

#' @importFrom devtools as.package
#' @export
rox_off <- function(pkg = ".") {
  pkg <- as.package(pkg)
  repo <- git2r::repository(pkg$path)

  check_git_clean(repo)
  gitignore(repo, add = TRUE)
  remove_documentation(repo)
  add_autoroxy(pkg, repo)
  add_autoroxy_dep(pkg, repo)
  dirty_commit(repo, "rox_off: documentation is not version-controlled")
}
