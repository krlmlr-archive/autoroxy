create_temp_package <- function() {
  test_dir <- tempfile("autoroxy-test", fileext = "dir")
  dir.create(test_dir)
  file.copy("testDocumentation", test_dir, recursive = TRUE)
  pkg_path <- file.path(test_dir, "testDocumentation")
  repo <- git2r::init(pkg_path)
  git2r::config(repo, user.name="Alice", user.email="alice@example.org")
  git2r::add(repo, "*")
  git2r::commit(repo, "initial")
  repo
}
