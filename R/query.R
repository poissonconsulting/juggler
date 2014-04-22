#' Get distributions in JAGS model code
#' 
#' Gets distributions in JAGS model code
#' 
#' @param x string of JAGS model code
#' @return Character vector of distributions.
#' @seealso \code{\link{juggler}}, 
#' \code{\link{jg_funcs}}, \code{\link{jg_parms}}
#' \code{\link{jg_indices}} and \code{\link{jg_data}}
#' @export
jg_dists <- function (x) {
  assert_that(is.string(x))
  
  matches <- gregexpr("(?<=~)\\s*\\w+(?=\\s*[(])", x, perl = TRUE)
  matches <- regmatches(x, matches)[[1]]
  matches <- gsub("\\s", "", matches)
  sort(unique(matches))
}

#' Get functions in JAGS model code
#' 
#' Gets functions in JAGS model code
#' 
#' @param x string of JAGS model code
#' @return Character vector of functions.
#' @seealso \code{\link{juggler}}, \code{\link{jg_dists}}, 
#' \code{\link{jg_parms}}
#' \code{\link{jg_indices}} and \code{\link{jg_data}}
#' @export
jg_funcs <- function (x) {
  assert_that(is.string(x))
  
  matches <- gregexpr("[^\\s]\\s*\\w+(?=\\s*[(])", x, perl = TRUE)
  matches <- regmatches(x, matches)[[1]]
  matches <- matches[!grepl("^~", matches)]
  matches <- gsub("^[^\\s]\\s*", "", matches)
  sort(unique(matches))
}

#' Get named nodes in JAGS model code
#' 
#' Gets named nodes in JAGS model code
#' 
#' @param x string of JAGS model code
#' @param type string of parameter type. Must be 'stochastic', 'deterministic'
#' or 'both' (the default).
#' @param indices flag of whether to retain indices
#' @return Character vector of indices.
#' @seealso \code{\link{juggler}}, \code{\link{jg_dists}}, 
#' \code{\link{jg_funcs}},
#' \code{\link{jg_indices}} and \code{\link{jg_data}}
#' @export
jg_named_nodes <- function (x, type = "both", indices = FALSE) {
  assert_that(is.string(x))
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

#' Get indices in JAGS model code
#' 
#' Gets indices in JAGS model code
#' 
#' @param x string of JAGS model code
#' @param type string of index type. Must be 'for' (the default), 'lookup'
#' or 'both'.
#' @return Character vector of indices.
#' @seealso \code{\link{juggler}}, \code{\link{jg_dists}}, 
#' \code{\link{jg_funcs}}, \code{\link{jg_parms}}
#' and \code{\link{jg_data}}
jg_indices <- function (x, type = "for") {
  assert_that(is.string(x))
  assert_that(is.string(type))
  
  if(!type %in% c("for", "lookup", "both"))
    stop("type must be 'for', 'lookup' or 'both'")
  
  if(type != "for")
    stop("currently only implemented for type 'for'")
  
  matches <- gregexpr("\\sfor\\s*(", x, perl = TRUE)
  matches <- regmatches(x, matches)[[1]]
}

jg_words <- function (x) {
  assert_that(is.string(x))
  matches <- gregexpr("(?<=[^\\w])[[:alpha:]]\\w*", x, perl = TRUE)
  matches <- regmatches(x, matches)[[1]]
  matches <- sort(unique(matches))
  matches
}

#' Get data variables in JAGS model code
#' 
#' Gets data variables in JAGS model code
#' 
#' @param x string of JAGS model code
#' @return Character vector of data variables.
#' @seealso \code{\link{juggler}}, \code{\link{jg_dists}}, 
#' \code{\link{jg_funcs}}, \code{\link{jg_parms}}
#' and \code{\link{jg_indices}}
#' @export
jg_data <- function (x) {
  assert_that(is.string(x))
}
