context("jgmodel")

test_that("jgmodel", {
  
  model_code <- "data {
  Y2 <- Y * 2
}
  model {
    bIntercept ~ dnorm(0, 5^-2) #}}}}
    bX ~ dnorm(0, 5^-2)
    sY ~ dunif(0, 5)
    for(i in 1:length(Y)) {
      mu[i] <- bIntercept + bX * X[i]
      Y2[i] ~ dnorm (mu[i], sY^-2)
    }
} "
  
  expect_is(jgmodel(model_code), "jgmodel")
  
  "model {
  for (i in 1:length(Volume)) {
  prediction[i] <- bIntercept + bGirth * Girth[i]
  E[i] <- pow(Volume[i] - prediction[i], 2) / prediction[i]
  newVolume[i] ~ dnorm(prediction, sVolume^-2)
  E2[i] <- pow(newVolume[i] - prediction[i], 2) / prediction[i]
  }
  EE[1] <- sum(E)
  EE[2] <- sum(E2)
  }"
  expect_is(jgmodel(x), "jgmodel")
  
  x <- "data {
  Y2 <- Y * 2
  }
  model {
  bIntercept ~ dnorm(0, 5^-2) #}}}}
  bX ~ dnorm(0, 5^-2)
  sY ~ dunif(0, 5)
  for(i in (0+1):length(Y)) {
  mu[i] <- bIntercept + bX * X[i]
  Y2[i] ~ dnorm (mu[i], sY^-2)
  }
  } "
  
  expect_is(jgmodel(x), "jgmodel")
})