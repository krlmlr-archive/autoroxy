gitignore <- function(repo, entry, add) { # nolint
  gitignore_path <- file.path(git2r::workdir(repo), ".gitignore")
  gitignore_contents <- if (file.exists(gitignore_path)) {
    readLines(gitignore_path)
  } else {
    character()
  }
  entry_pos <- which(entry == gitignore_contents)

  if (length(entry_pos) == 0) {
    if (add) {
      writeLines(c(gitignore_contents, entry), gitignore_path)
      git2r::add(repo, ".gitignore")
    } else {
      warning("Entry ", entry, " not found in ", gitignore_path, ".",
              call. = FALSE)
    }
  } else {
    if (add) {
      warning("Entry ", entry, " already contained in ", gitignore_path, ".",
              call. = FALSE)
    } else {
      writeLines(gitignore_contents[-entry_pos], gitignore_path)
      git2r::add(repo, ".gitignore")
    }
  }
}
