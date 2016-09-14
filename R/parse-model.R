parse_model <- function(x) {
  stopifnot(is.string(x))
  
  blocks <- list()
  class(blocks) <- "jgmodel"

  i <- 1
  repeat {
    i <- start_of_block(x, i) # i becomes start and end
    block_name <- block_name(i[1], i[2])
    i[1] <- i + 1 
    blocks[block_name] <- pass_brackets(x, i[2])
    names(blocks)[nblocks] <- block_name
    
    print(str_sub(x, i))

    if (str_detect(str_sub(x, i), "^\\s*$")) {
      return(blocks)
    }
  }
}
