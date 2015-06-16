add_documentation <- function(pkg, repo) {
  devtools::document()
  git2r::add(repo, "/man/*")
}

remove_documentation <- function(pkg, repo) {
  git2r::rm_file(repo, dir(file.path(git2r::workdir(repo), "man"), full.names = TRUE))
}
