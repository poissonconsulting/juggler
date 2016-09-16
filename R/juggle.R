#' Juggle JAGS model code
#' 
#' Juggles JAGS model code, i.e., 
#' takes code in the JAGS dialect of the BUGS language
#' and produces alternative models from model fragments.
#' 
#' jg_juggle currently requires that each node be defined on
#' a separate line of code. It takes advantage of the fact
#' that each node is unique.
#'   
#' @param x string of JAGS model code
#' @param fragments A character vector of model fragments
#' @return A character vector of alternative JAGS models.
#' @export
jg_juggle <- function(x, fragments = character(0)) {
  jg_check(x)
  
  x %<>% replicate_model_codes(fragments)
  x
}
