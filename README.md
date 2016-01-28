# [autoroxy](http://krlmlr.github.io/autoroxy) [![Travis-CI Build Status](https://travis-ci.org/krlmlr/autoroxy.svg?branch=master)](https://travis-ci.org/krlmlr/autoroxy) [![wercker status](https://app.wercker.com/status/2d2daeeb34cd2e4507e2f146ff47d251/s/master "wercker status")](https://app.wercker.com/project/bykey/2d2daeeb34cd2e4507e2f146ff47d251) [![codecov.io](https://codecov.io/github/krlmlr/autoroxy/coverage.svg?branch=master)](https://codecov.io/github/krlmlr/autoroxy?branch=master)

Automatically generate roxygen2 documentation.  Simply call `rox::off()` for development, `rox::on()` before releasing.  This is best done in two separate branches, as demonstrated in this repository.  The [`master` branch](https://github.com/krlmlr/autoroxy) doesn't contain the `man` directory, but the [`production` branch](https://github.com/krlmlr/autoroxy/tree/production) does.  Development happens in `master` as usual, the `production` branch is used only for releases.  See [the documentation](http://krlmlr.github.io/autoroxy/rox.html) for more details.

This also works with [Travis CI](https://travis-ci.org/) but requires the following entry in `.travis.yml` to trigger the generation of the documentation ([code](https://github.com/krlmlr/autoroxy/blob/a9d7e626d8bbbf1a0c9939d072ba16694381f963/.travis.yml#L7-L8)):

```
before_script: R CMD INSTALL .
```
