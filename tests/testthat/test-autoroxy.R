context("documentation")

test_that("can build package", {
  repo <- create_temp_package()
  pkg_path <- repo@path
  expect_commit(rox_off(pkg_path), "rox_off")

  on.exit(unlink("testDocumentation_0.0-0.tar.gz"), add = TRUE)
  devtools::build(pkg_path, quiet = TRUE, path = ".")

  tar_list <- untar("testDocumentation_0.0-0.tar.gz", list = TRUE)
  expect_false("testDocumentation/man/" %in% tar_list)
  expect_false("testDocumentation/man/dummy.Rd" %in% tar_list)
})

test_that("will not check package", {
  repo <- create_temp_package()
  pkg_path <- repo@path
  expect_commit(rox_off(pkg_path), "rox_off")

  on.exit(unlink("testDocumentation.Rcheck", recursive = TRUE), add = TRUE)

  res <- devtools::check(pkg_path, document = FALSE, check_dir = ".",
                         quiet = TRUE)
  expect_gt(length(res$errors), 0)
})

test_that("will create documentation during load_all", {
  repo <- create_temp_package()
  pkg_path <- repo@path
  expect_commit(rox_off(pkg_path), "rox_off")
  expect_true(git_clean(repo))

  expect_false(file.exists(file.path(pkg_path, "man")))
  expect_false(file.exists(file.path(pkg_path, "man", "dummy.Rd")))

  expect_output(expect_commit(rox_on(pkg_path), "rox_on"), "dummy[.]Rd")
  expect_true(git_clean(repo))

  expect_true(file.exists(file.path(pkg_path, "man")))
  expect_true(file.exists(file.path(pkg_path, "man", "dummy.Rd")))

  expect_commit(rox_off(pkg_path), "rox_off")
  expect_true(git_clean(repo))

  expect_false(file.exists(file.path(pkg_path, "man")))
  expect_false(file.exists(file.path(pkg_path, "man", "dummy.Rd")))

  expect_output(
    expect_message(devtools::load_all(pkg_path), "[*][*][*] autoroxy"),
    "dummy[.]Rd")
  expect_true(file.exists(file.path(pkg_path, "man")))
  expect_true(file.exists(file.path(pkg_path, "man", "dummy.Rd")))

  expect_commit(rox_on(pkg_path), "rox_on")
  expect_true(git_clean(repo))

  expect_true(file.exists(file.path(pkg_path, "man")))
  expect_true(file.exists(file.path(pkg_path, "man", "dummy.Rd")))

  expect_commit(rox_off(pkg_path), "rox_off")
  expect_true(git_clean(repo))

  expect_false(file.exists(file.path(pkg_path, "man")))
  expect_false(file.exists(file.path(pkg_path, "man", "dummy.Rd")))
})
