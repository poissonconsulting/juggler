#' Check JAGS model code
#' 
#' Checks JAGS model code
#' 
#' @param x string of JAGS model code
#' @return Invisible flag of whether JAGS model code passes certain checks.
#' In addition, a unique warning is issued for each failed check.
#' @export
jg_check <- function(x) {
  x <- jg_rm_comments(x)
  
  flag <- TRUE
  
  bnames <- try(jg_block_names(x))
  if (inherits(bnames, "try-error")){
    warning("unbalanced brackets")
    return (FALSE)
  } 
  
  if (!"model" %in% bnames) {
    warning("no model block")
    return (FALSE)
  }
  
  if (any(duplicated(bnames))) {
    warning("duplicated block names: ", paste_names(bnames[duplicated(bnames)], TRUE))
    flag <- FALSE
  }
  
  if(any(!bnames %in% jags_block_names())) {
    warning("invalid block names: ", paste_names(bnames[!bnames %in% jags_block_names()], TRUE))
    flag <- FALSE
  } else {
    fnames <- as.integer(factor(bnames, jags_block_names()))
    if(is.unsorted(fnames)) {
      warning("block order must be: ", paste_names(jags_block_names(), TRUE))
      flag <- FALSE
    }
  }
  nodes <- jg_vnodes(x, indices = FALSE)
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
