pass_blocks <- function (x, i) {
  if(missing(i))
    i <- 1
  x <- check_string(x)
  nx <- nchar(x)
  sc <- substr(x, i, i)
  blocks <- character(0)
  nblocks <- 0
  repeat{
    ii <- regexpr("^\\s*[A-Za-z][\\w.]*\\s*(?=[{])", substr(x, i, nx), perl = TRUE)
    if(ii == -1)
      stop("invalid block name syntax")
    block_name <- regmatches(substr(x, i, nx), ii)
    i <- i + ii + attr(ii, "match.length") - 1
    i <- pass_brackets(x, i)
    i[1] <- i + 1 
    nblocks <- nblocks + 1
    blocks[nblocks] <- names(i)
    names(blocks)[nblocks] <- gsub("\\s*", "", block_name)
    if(grepl("^\\s*$", substr(x, i, nx)))
      return (blocks)
  }
}

#' Parses blocks in JAGS model code
#' 
#' Converts blocks in JAGS model code into a named
#' character vector where the names are the block names.
#' 
#' @param x string of JAGS model code
#' @return A named character vector where the names are the block names.
#' Throws an error if the brackets are unbalanced.
#' @seealso \code{\link{juggler}} and \code{\link{jg_blks}}
#' @examples
#' jg_blks("data {X <- 2} model { Y ~ dpois(X) }")
#' @export
jg_blks <- function (x) {
  pass_blocks(x)
}

#' Get number of blocks in JAGS model code
#' 
#' Gets number of blocks in JAGS model code.
#' Throws an error if unbalanced brackets
#' 
#' @param x string of JAGS model code
#' @return Count of number of blocks.
#' @seealso \code{\link{juggler}} and \code{\link{jg_blks}}
#' @examples
#' jg_nblk("data {X <- 2} model { Y ~ dpois(X) }")
#' @export
jg_nblk <- function (x) {
  length(jg_blks(x))
}

#' Get block names in JAGS model code
#' 
#' Get block names in JAGS model code
#' 
#' @param x string of JAGS model code
#' @return A character vector of block names in order occur in code.
#' @seealso \code{\link{juggler}} and \code{\link{jg_blks}}
#' @examples
#' jg_blk_names("data {X <- 2} model { Y ~ dpois(X) }")
#' @export
jg_blk_names <- function (x) {
  names(jg_blks(x))
}
