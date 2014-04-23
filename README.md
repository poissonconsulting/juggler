# juggler

## Overview

R package for simple checking, querying and modification
of JAGS model code.

## Installation

To install use the `devtools` package:

    library(devtools)
    install_github("poissonconsulting/juggler@v0.1.1")
    library(juggler)
    ls("package:juggler")
    ?juggler

## Use

All the functions take code for a single JAGS model in the form of string. If the 
model code is in the form of a character vector then the functions first collapse the 
vectors into a string using `paste0(x,sep="\n")`. They then strip comments.

The most useful function for most people is likely `jg_check()`. Run this on
JAGS model code to perform some basic checks such as balanced brackets
and valid block, distribution and function names. 
It might save time if you have some code you want to check and no data to hand.
