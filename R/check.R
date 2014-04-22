#' Check JAGS model code
#' 
#' Checks JAGS model code
#' 
#' @param x string of JAGS model code
#' @return Invisible flag of whether JAGS model code passes certain checks.
#' In addition, a unique warning is issued for each failed check.
#' @seealso \code{\link{juggler}} and \code{\link{is.matched_brackets}}
#' @export
chk_jg <- function (x) {
  assert_that(is.string(x))
  
  flag <- TRUE
  
  if(!is.matched_brackets(x)) {
    warning("unmatched brackets")   
    flag <- FALSE
  } 
  
  nblocks <- jg_nblocks(x)
  
  if(nblocks == 0) {
    warning("no blocks defined")
    flag <- FALSE
  }
  if(nblocks > 2) {
    warning("more than two blocks defined")
  }
  
  blocks <- jg_blocks(x)
  
  if(!any(blocks %in% c("data", "model"))) {
    blocks <- blocks[!blocks %in% c("data", "model")]
    warning("invalid block names '", paste(blocks, collapse = "', '"), "'")
    flag <- FALSE
  } else if(nblocks == 2 && identical(blocks[1],blocks[2])) {
    warning("two '", blocks[1], "' blocks")
  }
  
  parms <- jg_parameters(x, indices = FALSE)
  if(identical(parms, "character(0)")) {
    warning("no parameters")
    flag <- FALSE
  } else if(any(parms %in% jags_reserved_words())) {
    parms <- parms[parms %in% jags_reserved_words()]
    warning("invalid parameter names '", paste(parms, collapse = "', '"), "'")    
    flag <- FALSE
  }
  
  dists <- jg_distributions(x)
  dists <- dists[!dists %in% jags_distributions()]
  if(!identical(dists, character(0))) {
    warning("invalid distributions '", paste(dists, collapse = "', '"), "'")    
    flag <- FALSE
  }
  
  funcs <- jg_functions(x)
  funcs <- funcs[!funcs %in% jags_functions()]
  if(!identical(funcs, character(0))) {
    warning("invalid functions '", paste(funcs, collapse = "', '"), "'")    
    flag <- FALSE
  }
  
  return(invisible(flag))
}
