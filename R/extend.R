#' Extend JAGS model code
#' 
#' Extends JAGS model code, i.e., converts it from
#' code in the JAGS dialect of the BUGS language to 
#' code in the JAGS dialect of the extended BUGS language.
#' In addition to the data and model blocks 
#' the extended BUGS languge allows a predict and/or aggregate block.
#' The predict block is used to estimate new expected 
#' values while the aggregate block is used to estimate metrics for the entire
#' dataset. The former is useful for exploring the models predictions and 
#' calculation of residuals while the latter is useful for posterior predictive
#' checking among other things. The advantages of separating the predictive
#' and aggregative code from the model code are 
#' 1) the model code runs quicker; 
#' 2) the predictive code can be run with user provided datasets to generate
#' predictions under unobserved combinations of data;
#' 3) the predictive or aggregative code can be changed without requiring the
#' model code to be rerun.
#' 
#' In order for the current function to extend some JAGS code it
#' requires the predictive and/or aggregative code segments to be identified
#' line by line using a #' comment followed by one or more of m, p and a
#' (the order is not important) to indicate to which 
#' blocks the line of code belongs.
#' Thus #' p indicates that the line belongs only in the predictive
#' block while #' am results in the line occuring in both the aggregative
#' and model blocks.
#' 
#' @param x string of JAGS model code
#' @return String of model code in JAGS dialect of extended BUGS language
#' or FALSE if fails (in which case also throws an error).
#' @seealso \code{\link{juggler}}
#' @export
jg_extend <- function (x) {
  
}


