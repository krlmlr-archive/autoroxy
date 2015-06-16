add_documentation <- function(pkg, repo) {
  devtools::document(pkg)
  git2r::add(repo, man_files(repo))
}

remove_documentation <- function(repo) {
  git2r::rm_file(repo, man_files(repo))
}

man_files <- function(repo) {
  file.path("man", dir(file.path(git2r::workdir(repo), "man")))
}
