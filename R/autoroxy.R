#' Generate roxygen2 documentation during installation from source
#'
#' Add the body of this function
#' to any file in your \code{R} directory.
#' (This is done automatically by \code{\link{rox_off}}.)
#'
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
  gsub(" +$", "", format(body(autoroxy)))
}

autoroxy_dir <- function() {
  "R"
}

autoroxy_file <- function() {
  "zzz-autoroxy.R"
}

autoroxy_path <- function(pkg) {
  file_name <- autoroxy_file()
  dir_path <- file.path(pkg$path, autoroxy_dir())
  if (!file.exists(dir_path))
    dir.create(dir_path)
  file.path(dir_path, file_name)
}

add_autoroxy <- function(pkg, repo) {
  pkg <- as.package(pkg)
  writeLines(c("# nolint start", autoroxy_code(), "# nolint end"),
             autoroxy_path(pkg))
  git2r::add(repo, "R")
  roxygen2::update_collate(pkg$path)
  git2r::add(repo, "DESCRIPTION")
}

remove_autoroxy <- function(pkg, repo) {
  pkg <- as.package(pkg)
  git2r::rm_file(repo, file.path(autoroxy_dir(), autoroxy_file()))
  git2r::add(repo, "R")
  roxygen2::update_collate(pkg$path)
  git2r::add(repo, "DESCRIPTION")
}
