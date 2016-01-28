#' Turn version-controlled documentation on and off
#'
#' Documentation, if generated automatically by, e.g., \code{roxygen2},
#' is a build artifact that ideally should not be added to a version
#' control system.  On the other hand, it seems necessary to
#' version-control the documentation:
#' \itemize{
#'   \item direct installation (via R CMD \code{\link[utils]{INSTALL}} and others)
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
#' documentation, abbreviated by ``off'' and ``on'' mode.
#' (This affects only the \code{man} directory, the \code{NAMESPACE}
#' and \code{DESCRIPTION} files are always version-controlled.)
#' Currently, this is an all-or-nothing decision:
#' It is not possible to keep only selected files version-controlled.
#' Even in ``off'' mode, it can be built like usual -- only that
#' the changes in the generated files are not tracked by the version control
#' system. Moreover, in ``off'' mode a file that contains the body of
#' \code{\link{autoroxy}} is written to a special file in the \code{R} directory;
#' this has the effect that documentation is available even with
#' \code{R CMD INSTALL} but is harmless otherwise.  (This special file is
#' removed again in ``on'' mode.)
#'
#' The Git repository must be in a clean state, i.e., the command
#' \code{git status} shows no changes.
#' On success, the changes are committed to Git.
#' When repeatedly calling the same function twice, the second call should have
#' no effect.
#'
#' Repeatedly turning documentation on an off in the same branch
#' clutters the history.  Hence, it is recommended to perform
#' development in a dedicated \emph{development} branch and keep the
#' documentation only in a \emph{release} branch.
#'
#' One way to achieve this is to use the \code{git flow} command line tool.
#' By default, \code{git flow} uses \code{develop} as development and
#' \code{master} as release branch; I recommend using \code{master} for
#' development and \code{production} for releases, the description below follows
#' this convention.  Documentation should be turned
#' off in the \code{master} branch (and hence all feature branches derived from
#' there), turned on as soon as a release is started, and turned off again
#' after merging a released version back to \code{master}.
#' Hooks can help automating this process.
#' As the history in the \code{production} branch contains
#' only merges from release branches, even repeated turning off and on
#' of documentation in development branches doesn't show in the mainline
#' history of \code{production}.  Remember to run at least
#' \code{git diff --name-status master..} before finishing a release.
#'
#' @inheritParams devtools::install
#'
#' @seealso
#'   \code{\link[devtools]{as.package}},
#'   \code{\link[devtools]{install}},
#'   \code{\link[roxygen2]{roxygenize}}
#'
#' @references
#'   Vincent Driessen:
#'   \href{nvie.com/posts/a-successful-git-branching-model/}{Git Flow: A successful branching model},
#'   blog post
#'
#'   Git Flow, \href{https://github.com/petervanderdoes/gitflow}{AVH edition}
#'
#'
#' @importFrom devtools as.package document
#' @export
#' @name rox
#' @aliases rox_on
rox_on <- function(pkg = ".") {
  pkg <- as.package(pkg)
  repo <- git2r::repository(pkg$path)

  check_git_clean(repo)
  gitignore(repo, "/man", add = FALSE)
  gitignore(repo, "/NAMESPACE", add = FALSE)
  add_documentation(pkg, repo)
  remove_autoroxy(pkg, repo)
  dirty_commit(repo, "rox_on: documentation is version-controlled")
}

#' @importFrom devtools as.package
#' @export
#' @rdname rox
rox_off <- function(pkg = ".") {
  pkg <- as.package(pkg)
  repo <- git2r::repository(pkg$path)

  check_git_clean(repo)
  gitignore(repo, "/man", add = TRUE)
  gitignore(repo, "/NAMESPACE", add = TRUE)
  remove_documentation(repo)
  add_autoroxy(pkg, repo)
  dirty_commit(repo, "rox_off: documentation is not version-controlled")
}
