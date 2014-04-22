\name{jg_nblk}
\alias{jg_nblk}
\title{Get number of blocks in JAGS model code}
\usage{
jg_nblk(x)
}
\arguments{
  \item{x}{string of JAGS model code}
}
\value{
Count of number of blocks.
}
\description{
Gets number of blocks in JAGS model code. Throws an error
if unbalanced brackets
}
\examples{
jg_nblk("data {X <- 2} model { Y ~ dpois(X) }")
}
\seealso{
\code{\link{juggler}} and \code{\link{jg_blks}}
}

