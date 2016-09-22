
#' Generate every version of a Model_Code
#'
#' @param x is Super Model Code to replicate
#' @param fragments is a vector of Fragments defining different versions of the Model
#' @export
jg_replicate_modelcode <- function(x,fragments) {
  
  Output <- vector("list",length(fragments)+1)
  Output[[1]] <- x
  
  for(i in 1:length(fragments)){
    Output[[i+1]] <- jg_generate_modelcode(x,fragments[[i]])
  }
  
  for(i in 1:length(Output)){
    Output[[i]] %<>% jg_specialise_modelcode()
  }
  
  Output
}
