\name{jg_set_block}
\alias{jg_set_block}
\title{Get JAGS model code block name}
\usage{
jg_set_block(x, name = "data", n = 1)
}
\arguments{
  \item{x}{string of JAGS model code}

  \item{name}{string of new block name which must be 'data'
  or 'model'.}

  \item{n}{count of position of block in model code which
  must not be greater than the number of blocks.}
}
\value{
String of modified JAGS model code.
}
\description{
Sets the name of a block in a JAGS model code string
}
\seealso{
\code{\link{juggler}}, \code{\link{jg_nblocks}} and
\code{\link{jg_blocks}}
}

