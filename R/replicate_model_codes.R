
#' Generate every version of a Model_Code
#'
#' @param x is Super Model Code to replicate
#' @param fragments is a vector of Fragments defining different versions of the Model
#' @export
replicate_model_codes <- function(x,fragments) {
  
  Output <- vector("list",length(fragments)+1)
  Output[[1]] <- x
  
  for(i in 1:length(fragments)){
    Output[[i+1]] <- generate_model_code_version(x,fragments[[i]])
  }
  
  Output
}
