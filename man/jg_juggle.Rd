\name{jg_juggle}
\alias{jg_juggle}
\title{Juggle JAGS model code}
\usage{
jg_juggle(x, ..., combine = FALSE)
}
\arguments{
  \item{x}{string of JAGS model code}
}
\value{
Strings of model code in JAGS dialect of BUGS language or
FALSE if fails (in which case also gives a warning).
}
\description{
Juggles JAGS model code, i.e., takes code in the JAGS
dialect of the BUGS language and produces alternative
models from model fragments. The fragments which must be in
the data and/or model block can be used to change, remove
or add nodes. Note jg_juggle has not been implemented for
the extended BUGS language but can be applied before code
is extended.
}
\details{
jg_juggle currently requires that each node be defined on a
separate line of code. It takes advantage of the fact that
each node is unique. Thus to replace a node all one has to
do it specify the new line of code for the node. To remove
a node the syntax node <- NULL is used. Any nodes that are
in the fragment but not the code under modification are
added at the highest level unless they are bracketed by one
or more pairs of {}s in which case the bracketing is copied
as well. Constant nodes that are rendered childless by this
process are automatically removed.

By default the JAGS model code specified by x is modified
independently by each of the code fragments in ... to
produce nargs() - 1 strings of complete JAGS model code. If
however combine = TRUE then x is modified by all
combinations of the code fragments.
}
\seealso{
\code{\link{juggler}}
}

