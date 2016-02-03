add_documentation <- function(pkg, repo) {
  devtools::document(pkg)
  git2r::add(repo, man_files(repo))
}

remove_documentation <- function(repo) {
  files <- man_files(repo)
  files <- files[file.exists(files)]
  if (length(files) == 0L) {
    warning("No documentation to remove.", call. = FALSE)
    return()
  }
  git2r::rm_file(repo, files)
  unlink(man_dir(repo), recursive = TRUE)
}

man_dir <- function(repo) {
  file.path(git2r::workdir(repo), "man")
}

man_files <- function(repo) {
  file.path("man", dir(man_dir(repo)))
}
