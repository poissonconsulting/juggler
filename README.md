
<!-- README.md is generated from README.Rmd. Please edit that file -->
[![Build Status](https://travis-ci.org/poissonconsulting/juggler.svg)](https://travis-ci.org/poissonconsulting/juggler) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/poissonconsulting/juggler?branch=master&svg=true)](https://ci.appveyor.com/project/poissonconsulting/juggler) [![codecov](https://codecov.io/gh/poissonconsulting/juggler/branch/master/graph/badge.svg)](https://codecov.io/gh/poissonconsulting/juggler)

juggler
=======

Introduction
------------

R package for simple checking, querying and modification of JAGS model code.

Installation
------------

To install from GitHub

    # install.packages("devtools")
    devtools::install_github("poissonconsulting/juggler")

Utilization
-----------

All the functions take code for a single JAGS model in the form of string. If the model code is in the form of a character vector then the functions first collapse the vectors into a string using `paste0(x,sep="\n")`. They then strip comments.

The most useful function for most people is likely `jg_check()`. Run this on JAGS model code to perform some basic checks such as balanced brackets and valid block, distribution and function names. It might save time if you have some code you want to check and no data to hand.
