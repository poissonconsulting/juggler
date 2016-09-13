
GenModel  <-function()
{
  model <- "model{
  y <- x^2
  z <- x^3
}" 
  model
}

GenFragments <- function() {
  fragments <- c("y <- x", "z <- x*2")
  fragments
}


ClearAll <- function()
{
  rm(list = ls())
}
