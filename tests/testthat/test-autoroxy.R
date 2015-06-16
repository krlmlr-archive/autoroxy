context("documentation")

test_that("can build package", {
  devtools::build("testDocumentation", quiet = TRUE)
  on.exit(unlink("testDocumentation_0.0-0.tar.gz"), add = TRUE)

  tar_list <- untar("testDocumentation_0.0-0.tar.gz", list = TRUE)
  expect_true("testDocumentation/man/" %in% tar_list)
  expect_true("testDocumentation/man/dummy.Rd" %in% tar_list)
})

test_that("can check package", {
  on.exit(unlink("testDocumentation.Rcheck", recursive = TRUE), add = TRUE)
  devtools::check("testDocumentation", document = FALSE, check_dir = ".", quiet = TRUE)
})
