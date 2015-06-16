context("documentation")

test_that("can build package", {
  devtools::build("testDocumentation")
  on.exit(unlink("testDocumentation_0.0-0.tar.gz"), add = TRUE)

  print(untar("testDocumentation_0.0-0.tar.gz", list = TRUE))
})

test_that("can check package", {
  on.exit(unlink("testDocumentation.Rcheck", recursive = TRUE), add = TRUE)
  expect_error(devtools::check("testDocumentation", document = FALSE,
                               check_dir = ".", quiet = TRUE))
})
