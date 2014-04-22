\name{jg_blks}
\alias{jg_blks}
\title{Parses blocks in JAGS model code}
\usage{
jg_blks(x)
}
\arguments{
  \item{x}{string of JAGS model code}
}
\value{
A named character vector where the names are the block
names. Throws an error if the brackets are unbalanced.
}
\description{
Converts blocks in JAGS model code into a named character
vector where the names are the block names.
}
\examples{
jg_blks("data {X <- 2} model { Y ~ dpois(X) }")
}
\seealso{
\code{\link{juggler}} and \code{\link{jg_blks}}
}

