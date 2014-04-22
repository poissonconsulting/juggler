\name{jg_nnodes}
\alias{jg_nnodes}
\title{Get named nodes in JAGS model code}
\usage{
jg_nnodes(x, type = "both", indices = FALSE)
}
\arguments{
  \item{x}{string of JAGS model code}

  \item{type}{string of parameter type. Must be
  'stochastic', 'deterministic' or 'both' (the default).}

  \item{indices}{flag of whether to retain indices}
}
\value{
Character vector of indices.
}
\description{
Gets named nodes in JAGS model code
}
\seealso{
\code{\link{juggler}}, \code{\link{jg_dists}}, and
\code{\link{jg_funcs}}
}

