#' @importFrom devtools as.package document
#' @export
rox_on <- function(pkg = ".") {
  pkg <- as.package(pkg)
  repo <- git2r::repository(pkg$path)

  check_git_clean(repo)
  gitignore(repo, add = FALSE)
  add_documentation(pkg, repo)
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
  dirty_commit(repo, "rox_off: documentation is not version-controlled")
}
