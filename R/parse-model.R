parse_model <- function(model_code) {
  stopifnot(is.string(model_code))
  i <- 1; n <- nchar(model_code); nblocks <- 1
  blocks <- list()

  repeat {
    loc <- str_sub(model_code, i, n) %>% str_locate("^\\s*[A-Za-z]+\\s*(?=[{])")
    if (is.na(loc[1,1])) stop("invalid block name syntax", .call = FALSE)
    loc %<>% as.vector() %>% add(i - 1)
    
    block_name <- str_sub(model_code, loc[1], loc[2]) %>% str_replace_all("\\s", "")
    
   #  <- parse_block(model_code, loc[2])
  #  i[1] <- i + 1
  #  blocks[name] <- 
  #  blocks[nblocks] <- names(i)
    
    if (str_detect(str_sub(model_code, i, n), "^\\s*$"))
      return(blocks)
    nblocks %<>% add(1)
  }
}
