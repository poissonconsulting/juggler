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
  x <- jg_rm_comments(x)
  
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
  x <- jg_rm_comments(x)
  
  matches <- gregexpr("((?<![\\s\\w.~])|(?<![~])\\s+)[A-Za-z][\\w.]*(?=\\s*[(])", x, perl = TRUE)
  matches <- regmatches(x, matches)[[1]]
  matches <- gsub("^\\s*", "", matches)
  sort(unique(matches))
}

#' Get variable nodes in JAGS model code
#' 
#' Gets names of variable (as opposed to constant) named nodes in JAGS model code
#' 
#' @param x string of JAGS model code
#' @param type string of node type. Must be 'stochastic', 'deterministic'
#' or 'both' (the default). A variable node is any word possibly 
#' @param indices flag of whether to retain indices
#' @return Character vector of unique sorted variable node names
#' @seealso \code{\link{juggler}}, \code{\link{jg_dists}}, 
#' and \code{\link{jg_funcs}}
#' @export
jg_vnodes <- function (x, type = "both", indices = FALSE) {
  x <- jg_rm_comments(x)
  
  assert_that(is.string(type))
  assert_that(is.flag(indices))
  
  if(!type %in% c("both", "stochastic", "deterministic"))
    stop("type must be 'both', 'stochastic' or 'deterministic'")
  
  if(type == "stochastic") {
    matches <- gregexpr("[])\\w.)](?=\\s*[~])", x, perl = TRUE)[[1]]
  } else if(type == "deterministic") {
    matches <- gregexpr("[])\\w.)](?=\\s*[<][-])", x, perl = TRUE)[[1]]   
  } else
    matches <- gregexpr("[])\\w.)](?=\\s*([~]|([<][-])))", x, perl = TRUE)[[1]]
  if(matches[1] == -1)
    return (character(0))
  
  nodes <- character(0)
  for (match in matches) {
    index <- NULL
    i <- gregexpr("\\S\\s*[)]$", substr(x, 1, match), perl = TRUE)[[1]]
    if (i[1] != -1)
      match <- i
    if("]" == substr(x, match, match)) {
      match <- pass_brackets(x, match, forward = FALSE)
      index <- names(match)
      match <- match - 1
    }
    i <- gregexpr("(^|(?<=[])(\\s]))[A-Za-z][\\w.]*(?=\\s*$)", substr(x, 1, match), perl = TRUE)[[1]]
    if(i[1] != -1) {
      node <- regmatches(substr(x, 1, match), i)
      if(indices && !is.null(index))
        node <- paste0(node, index)
      nodes <- c(nodes, node)
    }
  }
  nodes <- sort(unique(nodes))
  nodes
}
