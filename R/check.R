#' Check JAGS model code
#' 
#' Checks JAGS model code
#' 
#' @param x string of JAGS model code
#' @return Invisible flag of whether JAGS model code passes certain checks.
#' In addition, a unique warning is issued for each failed check.
#' @seealso \code{\link{juggler}}
#' @export
check_jags_code <- function (x) {
  assert_that(is.string(x))
  
  flag <- TRUE

  nodes <- jg_nnodes(x, indices = FALSE)
  if(identical(nodes, "character(0)")) {
    warning("no nodes")
    flag <- FALSE
  } else if(any(nodes %in% jags_reserved_words())) {
    nodes <- nodes[nodes %in% jags_reserved_words()]
    warning("invalid node names '", paste(nodes, collapse = "', '"), "'")    
    flag <- FALSE
  }
  
  dists <- jg_dists(x)
  dists <- dists[!dists %in% jags_distributions()]
  if(!identical(dists, character(0))) {
    warning("invalid distributions '", paste(dists, collapse = "', '"), "'")    
    flag <- FALSE
  }
  
  funcs <- jg_funcs(x)
  funcs <- funcs[!funcs %in% jags_functions()]
  if(!identical(funcs, character(0))) {
    warning("invalid functions '", paste(funcs, collapse = "', '"), "'")    
    flag <- FALSE
  }
  
  return(invisible(flag))
}
