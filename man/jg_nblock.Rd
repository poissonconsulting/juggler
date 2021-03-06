% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/blocks.R
\name{jg_nblock}
\alias{jg_nblock}
\title{Get number of blocks in JAGS model code}
\usage{
jg_nblock(x)
}
\arguments{
\item{x}{string of JAGS model code}
}
\value{
Count of number of blocks.
}
\description{
Gets number of blocks in JAGS model code.
Throws an error if unbalanced brackets
}
\examples{
jg_nblock("data {X <- 2} model { Y ~ dpois(X) }")
}
\seealso{
\code{\link{juggler}} and \code{\link{jg_blocks}}
}

