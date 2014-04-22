\name{chk_jg}
\alias{chk_jg}
\title{Check JAGS model code}
\usage{
chk_jg(x)
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
\code{\link{juggler}} and \code{\link{is.matched_brackets}}
}

