check_git_clean <- function(repo) {
  if (git_clean(repo)) {
    stop("Repository ", git2r::workdir(repo), " is not clean.", call. = FALSE)
  }
}

git_clean <- function(repo, kind = ) {
  length(unlist(git2r::status(repo)[kind])) == 0L)
}

dirty_commit <- function(repo, msg) {
  if (!git_clean(repo, kind = "staged")) {
    git2r::commit(repo, msg)
  }
}
