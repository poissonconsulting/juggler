#' Get and set JAGS model code block names
#' 
#' Gets character vector of the names of the blocks in a JAGS model code string
#' 
#' @param x string of JAGS model code
#' @return Character vector of block names.
#' @seealso \code{\link{juggler}}, \code{\link{jg_nblocks}} and 
#' \code{\link{jg_set_block}}
jg_block_names <- function (x) {
  assert_that(is.string(x))
  
  matches <- gregexpr("^\\s*\\w+(?=\\s*{)", x, perl = TRUE)
  matches <- regmatches(x, matches)[[1]]
  matches
}

#' Get number of JAGS model code blocks
#' 
#' Gets the number of blocks in a JAGS model code string
#' 
#' @param x string of JAGS model code
#' @return Count of the number of blocks.
#' @seealso \code{\link{juggler}}, \code{\link{jg_blocks}} and 
#' \code{\link{jg_set_block}}
jg_nblocks <- function (x) {
  length(jg_blocks(x))
}

#' Get JAGS model code block name
#' 
#' Sets the name of a block in a JAGS model code string
#' 
#' @param x string of JAGS model code
#' @param name string of new block name which must be 'data' or 'model'.
#' @param n count of position of block in model code which must not be
#' greater than the number of blocks.
#' @return String of modified JAGS model code.
#' @seealso \code{\link{juggler}}, \code{\link{jg_nblocks}} 
#' and \code{\link{jg_blocks}}
'jg_block_names<-' <- function (x, name = "data", n = 1) {
  assert_that(is.string(x))
  assert_that(is.string(name))
  assert_that(is.count(n))
  
  if(!name %in% c("model", "data"))
    stop("type must be 'model' or 'data'")
  
  if(n > jg_nblocks(x))
    stop("n must be less than ", jg_nblocks(x))
  
  if(!identical(n, 1))
    stop("currently only implemented for first block")
  
  block <- jg_blocks(x)[n]
  
  if(identical(block, name)) {
    message("model block ", n ," is already '", name, "'")
    return(invisible(TRUE))
  }
  
  sub("^\\s*\\w+(?=\\s*{)", name, x, perl = TRUE)
}
