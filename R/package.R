#' @title Juggler
#'
#' @description 
#' Simple querying and checking of JAGS model code.
#' 
#' @docType package
#' @import assertthat
#' @name juggler
#' @aliases package-juggler juggler-package
#' @seealso \code{\link{jg_check}}, \code{\link{jg_blocks}} and
#' \code{\link{jg_dists}}
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
