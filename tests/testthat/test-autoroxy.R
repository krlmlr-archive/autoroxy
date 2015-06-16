context("documentation")

test_that("can build package", {
  devtools::build("testDocumentation", quiet = TRUE)
  on.exit(unlink("testDocumentation_0.0-0.tar.gz"), add = TRUE)

  expect_true(all(untar("testDocumentation_0.0-0.tar.gz", list = TRUE) != "man"))
})

test_that("can check package", {
  on.exit(unlink("testDocumentation.Rcheck", recursive = TRUE), add = TRUE)
  expect_error(devtools::check("testDocumentation", document = FALSE,
                               check_dir = ".", quiet = TRUE))
})
