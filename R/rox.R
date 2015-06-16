#' @importFrom devtools as.package document
rox_on <- function(pkg = ".") {
  pkg <- as.package(pkg)
  repo <- git2r::repository(pkg$path)

  check_git_clean(repo)
  remove_from_gitignore(repo)
  add_documentation(pkg, repo)
  git2r::commit(repo, "rox_on: documentation is version-controlled")
}

#' @importFrom devtools as.package document
rox_off <- function(pkg = ".") {
  pkg <- as.package(pkg)
  repo <- git2r::repository(pkg$path)

  check_git_clean(repo)
  add_to_gitignore(repo)
  remove_documentation(repo)
  git2r::commit(repo, "rox_off: documentation is not version-controlled")
}
