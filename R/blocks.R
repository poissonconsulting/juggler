pass_blocks <- function (x, i) {
  if(missing(i))
    i <- 1
  x <- check_string(x)
  nx <- nchar(x)
  sc <- substr(x, i, i)
  blocks <- character(0)
  nblocks <- 0
  repeat{
    ii <- regexpr("^\\s*[A-Za-z][\\w.]*(?=\\s*[{])", substr(x, i, nx), perl = TRUE)
    if(ii == -1)
      stop("invalid block name syntax")
    block_name <- regmatches(substr(x, i, nx), ii)
    i <- i + ii + attr(ii, "match.length") - 1
    i <- pass_brackets(x, i)
    i[1] <- i + 1 
    nblocks <- nblocks + 1
    blocks[nblocks] <- names(i)
    names(blocks)[nblocks] <- sub("^\\s*", "", block_name)
    if(grepl("^\\s*$", substr(x, i, nx)))
      return (blocks)
  }
}
