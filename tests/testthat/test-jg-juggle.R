context("jg-juggle")

test_that("jg_juggle returns original", {
  model <- "model {
    bHeads ~ dunif(0, 1)
    for(i in 1:length(Toss)) {
      Toss[i] ~ dbern(bHeads)
    }
  }"

  expect_identical(jg_juggle(model), model)
})