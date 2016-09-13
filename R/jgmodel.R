is.jgmodel <- function(x) {
  inherits(x, "jgmodel")
}

jgmodel <- function(model_code) {
  check_vector(model_code, "")
  model_code %<>% paste0(collapse = "\n")
  
  x <- parse_model(model_code)
  class(x) <- "jgmodel"
  x
}

nblocks <- function(x) {
  stopifnot(is.jgmodel(x))
  length(x)
}

block_names <- function(x) {
  stopifnot(is.jgmodel(x))
  names(x) 
}
