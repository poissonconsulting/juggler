\name{jg_indices}
\alias{jg_indices}
\title{Get indices in JAGS model code}
\usage{
jg_indices(x, type = "for")
}
\arguments{
  \item{x}{string of JAGS model code}

  \item{type}{string of index type. Must be 'for' (the
  default), 'lookup' or 'both'.}
}
\value{
Character vector of indices.
}
\description{
Gets indices in JAGS model code
}
\seealso{
\code{\link{juggler}}, \code{\link{jg_dists}},
\code{\link{jg_funcs}}, \code{\link{jg_parms}} and
\code{\link{jg_data}}
}

