context("documentation")

test_that("can build package", {
  devtools::build("testDocumentation")
  on.exit(unlink("testDocumentation_0.0-0.tar.gz"), add = TRUE)

  print(untar("testDocumentation_0.0-0.tar.gz", list = TRUE))
})

test_that("can check package", {
#  devtools::check("testDocumentation", document = FALSE, check_dir = ".")
})
