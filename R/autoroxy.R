#' Generate roxygen2 documentation during installation from source
#'
#' Add a call to this function to any file in your \code{R} directory.
#' Use explicit qualification (like \code{autoroxy::autoroxy()}) to avoid
#' importing the package and its dependencies.
#' @export
autoroxy <- function() {
  if (!"DESCRIPTION" %in% dir()) {
    return(invisible(NULL))
  }

  if (file.exists("man")) {
    return(invisible(NULL))
  }

  if (grepl("/.*[.]Rcheck/00_pkg_src/.*$", normalizePath(getwd(), winslash = "/"))) {
    stop("Cannot run this function in R CMD check.")
  }

  message("*** autoroxy: creating documentation")

  if (!requireNamespace("roxygen2")) {
    warning("Cannot load roxygen2. Package documentation will be unavailable.", call. = FALSE)
    return(invisible(NULL))
  }

  roxygen2::roxygenize(roclets = c("rd"))
}

autoroxy_code <- function() {
  gsub(" +$", "", format(dput(body(autoroxy))))
}

autoroxy_file <- function(pkg) {
  file_name <- if (pkg$package == "autoroxy") {
    "zzz-autoroxy.R"
  } else {
    "aaa-autoroxy.R"
  }
  dir_path <- file.path(pkg$path, "R")
  if (!file.exists(dir_path))
    dir.create(dir_path)
  file.path(dir_path, file_name)
}

add_autoroxy <- function(pkg, repo) {
  pkg <- as.package(pkg)
  writeLines(autoroxy_code(), autoroxy_file(pkg))
  git2r::add(repo, "R")
}

remove_autoroxy <- function(pkg, repo) {
  pkg <- as.package(pkg)
  unlink(autoroxy_file(pkg))
  git2r::add(repo, "R")
}
