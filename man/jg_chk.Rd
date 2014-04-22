\name{jg_chk}
\alias{jg_chk}
\title{Check JAGS model code}
\usage{
jg_chk(x)
}
\arguments{
  \item{x}{string of JAGS model code}
}
\value{
Invisible flag of whether JAGS model code passes certain
checks. In addition, a unique warning is issued for each
failed check.
}
\description{
Checks JAGS model code
}
\seealso{
\code{\link{juggler}}
}

