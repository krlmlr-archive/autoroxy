check_git_clean <- function(repo) {
  if (length(unlist(git2r::status(repo))) != 0L) {
    stop("Repository ", git2r::workdir(repo), " is not clean.", call. = FALSE)
  }
}
