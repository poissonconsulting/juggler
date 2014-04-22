get_brackets <- function (x) {
  assert_that(is.string(x))
  
  matches <- gregexpr("[({})]", x)
  matches <- regmatches(x, matches)[[1]]
  matches <- paste0(matches, collapse = "")
  matches
}

is.matched_brackets <- function (x) {
  assert_that(is.string(x))
  
  x <- get_brackets(x)
  
  if(nchar(x) != nchar(gsub("[^({})]", "", x)))
    return(FALSE)
  
  nc <- 0
  ns <- 0
  for (i in 1:nchar(x)) {
    b <- substr(x, i, i)
    if(b == "(") {
      nc <- nc + 1
    } else if (b == ")") {
      nc <- nc - 1
    } else if (b == "{") {
      ns <- ns + 1
    } else
      ns <- ns - 1
    if(nc < 0 || ns < 0)
      return (FALSE)
  }
  nc == 0 && ns == 0
}
