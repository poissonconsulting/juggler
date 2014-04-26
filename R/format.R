#' Formats JAGS model code
#' 
#' Formats JAGS model code in the JAGS dialect of the BUGS language
#' (extended or string).
#' 
#' Note the juggler package currently requires that each relation
#' be defined on a separate line of code.
#'   
#' @param x string of JAGS model code
#' @return String of formatted model code or FALSE if fails 
#' (in which case also gives a warning).
#' @seealso \code{\link{juggler}}
#' @export
jg_format <- function (x, ..., combine = FALSE) {
  
}
