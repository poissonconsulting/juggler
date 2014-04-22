pass_brackets <- function (x, i) {
  sc <- substr(x, i, i)
  nx <- nchar(x)  
  repeat {
    ii <- as.integer(regexpr("[][{}()]", substr(x, i + 1, nx)))
    if(ii == -1) {
      stop ("unmatched brackets")
    }
    i <- i + ii
    ec <- substr(x, i, i)
    if(grepl("[[{(]", ec)) {
      i <- pass_brackets(x, i)
    } else if (ec == switch(sc, 
      "[" = "]",
      "{" = "}",
      "(" = ")",
      stop("error"))) {
      return (i)
    } else {
      stop("unmatched brackets")
    }
  }
}
