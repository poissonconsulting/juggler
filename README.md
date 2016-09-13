
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/poissonconsulting/juggler.svg)](https://travis-ci.org/poissonconsulting/juggler) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/poissonconsulting/juggler?branch=master&svg=true)](https://ci.appveyor.com/project/poissonconsulting/juggler) [![codecov](https://codecov.io/gh/poissonconsulting/juggler/branch/master/graph/badge.svg)](https://codecov.io/gh/poissonconsulting/juggler)

juggler
=======

Introduction
------------

R package for simple checking, querying and modification of JAGS model code.

All the functions take code for a single JAGS model in the form of string. If the model code is in the form of a character vector then the functions first collapse the vectors into a string using `paste0(x,sep="\n")`. They then strip comments.

The most useful function for most people is likely `jg_check()`. Run this on JAGS model code to perform some basic checks such as balanced brackets and valid block, distribution and function names.

Utilization
-----------

When presented with new code the first job is to use `jg_check` to see if the code has any problems. Once checked code can be combined with code fragments using `jg_juggle` to produce multiple models. If marked up using the MPAmpa syntax models can then be extended using `jg_extend` to produce fast, flexible code for passing to jaggernaut and/or for formatting using `jg_format` for your reports.

``` r
library(juggler)
x <- "data {
  Y2 <- Y * 2
}  
model {
  bIntercept ~ dnorm(0, 5^-2)
  bX ~ dnorm(0, 5^-2)
  sY ~ dunif(0, 5)

  for(i in 1:length(Y)) {
    mu[i] <- bIntercept + bX * X[i]
    Y2[i] ~ dnorm (mu[i], sY^-2)
  }
} "

jg_dists(x)
#> [1] "dnorm" "dunif"
jg_funcs(x)
#> [1] "for"    "length"
jg_vnodes(x)
#>   bIntercept           bX           mu           sY           Y2 
#> "bIntercept"         "bX"         "mu"         "sY"         "Y2"
jg_vnodes(x, indices = TRUE)
#>   bIntercept           bX           mu           sY           Y2 
#> "bIntercept"         "bX"      "mu[i]"         "sY"         "Y2" 
#>           Y2 
#>      "Y2[i]"
jg_vnodes(x, "stochastic", indices = TRUE)
#>   bIntercept           bX           sY           Y2 
#> "bIntercept"         "bX"         "sY"      "Y2[i]"
jg_vnodes(x, "deterministic")
#>   mu   Y2 
#> "mu" "Y2"
jg_block_names(x)
#> [1] "data"  "model"
print(jg_check(x))
#> [1] TRUE
```

Installation
------------

To install from GitHub

    # install.packages("devtools")
    devtools::install_github("poissonconsulting/juggler")
