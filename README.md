
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cveR <img src="man/figures/logo.png" align="right" height="138" />

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/Cdk29/cveR/branch/main/graph/badge.svg)](https://app.codecov.io/gh/Cdk29/cveR?branch=main)
[![R-CMD-check](https://github.com/Cdk29/cveR/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/Cdk29/cveR/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of cveR is monitor the publication of new CVEs.

## Notes

-   mongoDB does not seems to work on Shinyapps.io, locally

## Installation

You can install the development version of cveR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Cdk29/cveR")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
# library(cveR)
## basic example code
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/v1/examples>.
