\name{jg_parms}
\alias{jg_parms}
\title{Get parameters in JAGS model code}
\usage{
jg_parms(x, type = "both", indices = FALSE)
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
Gets parameters in JAGS model code
}
\seealso{
\code{\link{juggler}}, \code{\link{jg_dists}},
\code{\link{jg_funcs}}, \code{\link{jg_indices}} and
\code{\link{jg_data}}
}

