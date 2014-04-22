\name{jg_vnodes}
\alias{jg_vnodes}
\title{Get variable nodes in JAGS model code}
\usage{
jg_vnodes(x, type = "both", indices = FALSE)
}
\arguments{
  \item{x}{string of JAGS model code}

  \item{type}{string of node type. Must be 'stochastic',
  'deterministic' or 'both' (the default).}

  \item{indices}{flag of whether to retain indices}
}
\value{
Character vector of unique sorted indices.
}
\description{
Gets variable nodes in JAGS model code
}
\seealso{
\code{\link{juggler}}, \code{\link{jg_dists}}, and
\code{\link{jg_funcs}}
}

