#' Get distributions in JAGS model code
#' 
#' Gets distributions in JAGS model code.
#' A distribution is any JAGS word between ~ and (.
#' Where a JAGS word must start with a letter
#' and can only contain letters, numbers, '.'
#' and '_'.
#' 
#' @param x string of JAGS model code
#' @return Sorted character vector of distributions
#' that occur one or more times.
#' @seealso \code{\link{juggler}}, 
#' \code{\link{jg_funcs}}, \code{\link{jg_vnodes}}
#' @export
jg_dists <- function (x) {
  x <- check_string(x)
    
  matches <- gregexpr("(?<=~)\\s*[A-Za-z][\\w.]*(?=\\s*[(])", x, perl = TRUE)
  matches <- regmatches(x, matches)[[1]]
  matches <- gsub("\\s", "", matches)
  sort(unique(matches))
}

#' Get functions in JAGS model code
#' 
#' Gets functions in JAGS model code
#' A function is any JAGS word followed by a '('
#' that is not preceeded by a '~'.
#' Where a JAGS word must start with a letter
#' and can only contain letters, numbers, '.'
#' and '_'.
#'  
#' @param x string of JAGS model code
#' @return Character vector of functions.
#' @seealso \code{\link{juggler}}, \code{\link{jg_dists}}, 
#' and \code{\link{jg_vnodes}}
#' @export
jg_funcs <- function (x) {
  x <- check_string(x)
  
  matches <- gregexpr("((?<![\\s\\w.~])|(?<![~])\\s+)[A-Za-z][\\w.]*(?=\\s*[(])", x, perl = TRUE)
  matches <- regmatches(x, matches)[[1]]
  matches <- gsub("^\\s*", "", matches)
  sort(unique(matches))
}

#' Get variable nodes in JAGS model code
#' 
#' Gets variable nodes in JAGS model code
#' 
#' @param x string of JAGS model code
#' @param type string of node type. Must be 'stochastic', 'deterministic'
#' or 'both' (the default).
#' @param indices flag of whether to retain indices
#' @return Character vector of unique sorted indices.
#' @seealso \code{\link{juggler}}, \code{\link{jg_dists}}, 
#' and \code{\link{jg_funcs}}
#' @export
jg_vnodes <- function (x, type = "both", indices = FALSE) {
  x <- check_string(x)
  assert_that(is.string(type))
  assert_that(is.flag(indices))
  
  if(!type %in% c("both", "stochastic", "deterministic"))
    stop("type must be 'both', 'stochastic' or 'deterministic'")
  
  matches <- gregexpr("(\\w+)((?<=\\w)|(\\s*([[][^[][]])))\\s*([~]|([<][-]))", x, perl = TRUE)
  matches <- regmatches(x, matches)[[1]]
  
  if(type == "stochastic") {
    matches <- matches[grepl("~$", matches)]
  } else if (type == "deterministic")
    matches <- matches[grepl("<-$", matches)]
  
  matches <- gsub("\\s*(~|<-)$", "", matches)
  
  if(!indices)
    matches <- gsub("[[][^[][]]$", "", matches)
  
  matches <- sort(unique(matches))
  matches
}
