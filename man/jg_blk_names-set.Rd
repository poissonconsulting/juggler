\name{jg_blk_names<-}
\alias{jg_blk_names<-}
\title{Set block names in JAGS model code}
\usage{
jg_blk_names(x) <- value
}
\arguments{
  \item{x}{string of JAGS model code}

  \item{names}{character vector of block names}
}
\value{
Modified JAGS model code.
}
\description{
Sets block names in JAGS model code. Throws an error if
}
\examples{
x <- "data {X <- 2} model { Y ~ dpois(X) }"
jg_blk_names(x) <- c("settings", "model")
print(x)
}
\seealso{
\code{\link{juggler}} and \code{\link{jg_blks}}
}

