\docType{package}
\name{juggler}
\alias{juggler}
\alias{juggler-package}
\alias{package-juggler}
\title{Juggler}
\description{
Simple querying and checking of JAGS model code.
}
\examples{
x <- "data {
  Y2 <- Y * 2
}
model {
  bIntercept ~ dnorm(0, 5^-2)
  bX ~ dnorm(0, 5^-2)
  sY ~ dunif(0, 5)
  for(i in 1:length(Y)) {
    mu[i] <- bIntercept + bX * X[i]
    Y2[i] ~ dnorm (mu[i], sY^-2)
  }
} "

jg_dists(x)
jg_funcs(x)
jg_nnodes(x)
jg_nnodes(x, indices = TRUE)
jg_nnodes(x, "stochastic", indices = TRUE)
jg_nnodes(x, "deterministic")
print(check_jags_code(x))

\dontrun{

x <- "model2 {
Y2 <- Y * 2
}
data {
  bIntercept ~ dnorm(0, 5^-2)
  bX <- dnorm(0, 5^-2)
  dnorm ~ mean(0, 5)

  fore(i in 1:length(Y)) {
    mu[i] <- bIntercept + bX * X[i]
    Y2[i] ~ dorm (mu[i], sY^-2)
  }
} "

jg_dists(x)
jg_funcs(x)
jg_nnodes(x)
print(check_jags_code(x))
}
}
\seealso{
\code{\link{check_jags_code}} and \code{\link{jg_dists}}
}

