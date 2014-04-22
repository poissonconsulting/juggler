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
model_code1 <- "data {
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

jg_blocks(model_code1)
jg_nblocks(model_code1)
jg_set_block(model_code1, "data")
jg_set_block(model_code1, "model")
is.matched_brackets(model_code1)
jg_distributions(model_code1)
jg_functions(model_code1)
jg_parameters(model_code1)
jg_parameters(model_code1, indices = TRUE)
jg_parameters(model_code1, "stochastic", indices = TRUE)
jg_parameters(model_code1, "deterministic")
print(check_jags_model_code(model_code1))

\dontrun{

model_code2 <- "model2 {
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

jg_blocks(model_code2)
jg_distributions(model_code2)
jg_functions(model_code2)
jg_parameters(model_code2)
print(check_jags_model_code(model_code2))
}
}
\seealso{
\code{\link{chk_jg}}, \code{\link{jg_blocks}} and
\code{\link{jg_parms}}.
}

