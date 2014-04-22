context("jg_chk")

test_that("TRUE for valid code", {
  
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
  
  expect_that(jg_chk(x), is_true())
})

test_that("warnings and FALSE for invalid code", {
  
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
  
  expect_warning(y <- jg_chk(x))
  expect_false(y)
})
