eat_brackets <- function (x, i) {
  check_string(x)
  nx <- nchar(x)
  x <- reverse_strings(x)
  i <- nx - i + 1
  sc <- substr(x, i, i)
  i <- pass_brackets(x, i)
  i[1] <- nx - i[1] + 1
  names(i) <- reverse_strings(i)
  i
}

pass_brackets <- function (x, i) {
  sc <- substr(x, i, i)
  names(i) <- sc
  nx <- nchar(x)  
  repeat {
    ii <- as.integer(regexpr("[][{}()]", substr(x, i + 1, nx)))
    if(ii == -1) {
      stop ("unmatched brackets")
    }
    names(i) <- paste0(names(i),substr(x, i + 1, ii - 1)) 
    i[1] <- i[1] + ii[1]
    ec <- substr(x, i, i)
    if(grepl("[[{(]", ec)) {
      ii <- pass_brackets(x, i)
      names(i) <- paste0(names(i), names(ii))
      i[1] <- ii[1]
    } else if (ec == switch(sc, 
      "[" = "]",
      "{" = "}",
      "(" = ")",
      stop("error"))) {
      names(i) <- paste0(names(i), ec)
      return (i)
    } else {
      stop("unmatched brackets")
    }
  }
}  
