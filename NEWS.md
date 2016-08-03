## autoroxy 0.1-4 (2016-08-03)

- Use `devtools::document()` instead of `roxygen2::roxygenize()` to create the documentation.


## autoroxy 0.1-3 (2016-03-31)

- Enable sudo-less Travis with caching.


## autoroxy 0.1-2 (2016-03-30)

- Keep empty `zzz-autoroxy.R` file after `rox_on()` to allow detection of an autoroxy-enabled package.
- Fix tests failing due to changed behavior of `git2r` and `testthat` packages.


## autoroxy 0.1-1 (2016-03-30)

- Use `rflow`.
- Don't try `git2r::rm_file()` if file is missing
- `rox_on()` now also works if `rox_off()` was never called before.
- Tests fail for some reason.


Version 0.1 (2016-01-28)
===

First GitHub release, contains `rox_on()`, `rox_off()` and `autoroxy()`.

- Tested with Travis-CI and wercker.
