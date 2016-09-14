is.jgmodel <- function(x) {
  inherits(x, "jgmodel")
}

#' JG Model
#'
#' @param model_code A string or character vector of the model code.
#'
#' @return A jgmodel object
#' @export
jgmodel <- function(model_code) {
  check_vector(model_code, "")
  
  model_code %<>% collapse_vector_to_string()
  model_code %<>% rm_comments()
  
  obj <- parse_model(model_code)
  obj
}

nblocks <- function(x) {
  stopifnot(is.jgmodel(x))
  length(x)
}

block_names <- function(x) {
  stopifnot(is.jgmodel(x))
  names(x) 
}
