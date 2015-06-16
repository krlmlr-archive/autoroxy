check_git_clean <- function(repo) {
  if (git_clean(repo)) {
    stop("Repository ", git2r::workdir(repo), " is not clean.", call. = FALSE)
  }
}

git_clean <- function(repo) {
  length(unlist(git2r::status(repo))) == 0L)
}
