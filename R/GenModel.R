
GenModel  <-function()
{
  model <- "model{ #PM
for(i in 1:length(data)) { #P
  y[i] <- x[i]^2 
  z[i] <- x^3 #mp
 }
}" 
  model
}

GenFragments <- function() {
  fragments1 <- c("y <- x", "z <- x*2")
  fragments2 <- c("y <- x+1", "z <- x*2+1")
  fragments3 <- c("z <- x*2+1")
  fragments <- list(fragments1,fragments2,fragments3)
  fragments
}


ClearAll <- function()
{
  rm(list = ls())
}
