#' @title Juggler Package
#'
#' @description 
#' Check, manipulate and format JAGS model code.
#' 
#' When presented with new code the first job is to 
#' use jg_check to see if the code has 
#' any problems which may be fixable
#' using jg_fix or may require manually editing. Once checked
#' code can be combined with code fragments using jg_juggle to
#' produce multiple models. If marked up using the
#' #' MPAmpa syntax models can then be extended using
#' jg_extend to produce fast, flexible code for passing to jaggernaut
#' and/or for formatting using jg_format for your reports.
#' Alternatively jaggernaut does all this behind the scenes so just
#' pass it your MPAmpa marked up JAGS model code and fragments 
#' and the data of interest and 
#' it let 
#' efficiently and flexibly manipulate your code and perform the analyses 
#' for you. The other functions are primarily exported for
#' jaggernaut which imports the juggler package but you may 
#' find uses for them.
#' 
#' @docType package
#' @import assertthat datacheckr
#' @name juggler
#' @aliases package-juggler juggler-package
#' @seealso \code{\link{jg_check}}, \code{\link{jg_fix}},
#' \code{\link{jg_juggle}}, \code{\link{jg_extend}}
#' and \code{\link{jg_format}}.
#' @examples
#' 
#' x <- "data {
#'   Y2 <- Y * 2
#' }  
#' model {
#'   bIntercept ~ dnorm(0, 5^-2)
#'   bX ~ dnorm(0, 5^-2)
#'   sY ~ dunif(0, 5)
  
#'   for(i in 1:length(Y)) {
#'     mu[i] <- bIntercept + bX * X[i]
#'     Y2[i] ~ dnorm (mu[i], sY^-2)
#'   }
#' } "
#'
#' jg_dists(x)
#' jg_funcs(x)
#' jg_vnodes(x)
#' jg_vnodes(x, indices = TRUE)
#' jg_vnodes(x, "stochastic", indices = TRUE)
#' jg_vnodes(x, "deterministic")
#' jg_block_names(x)
#' print(jg_check(x))
#'  
#' \dontrun{ 
#' 
#' x <- "model2 {
#' Y2 <- Y * 2
#' }  
#' data {
#'   bIntercept ~ dnorm(0, 5^-2)
#'   bX <- dnorm(0, 5^-2)
#'   dnorm ~ mean(0, 5)
#'   
#'   fore(i in 1:length(Y)) {
#'     mu[i] <- bIntercept + bX * X[i]
#'     Y2[i] ~ dorm (mu[i], sY^-2)
#'   }
#' } "
#' 
#' jg_dists(x)
#' jg_funcs(x)
#' jg_nnodes(x)
#' print(jg_check(x))
#' }
#'
NULL
