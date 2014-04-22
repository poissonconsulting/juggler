context("number of blocks")

test_that("jg_nblk counts correct blocks", {
  
  expect_equal(jg_nblk("model {}"), 1)
  expect_equal(jg_nblk("model{}"), 1)
  expect_equal(jg_nblk("model{}data{}"), 2)
  expect_equal(jg_nblk("model{} data{}"), 2)
  expect_equal(jg_nblk("model{{x <- bt[1:2]}} data{}"), 2)
  expect_equal(jg_nblk("settings{} \n\ndata{} model{}"), 3)
#  expect_equal(jg_nblk("data {X <- 2} model { Y ~ }"), 2)
  expect_equal(jg_nblk("data{X <- 2} model{ Y ~ dpois(X) }"), 2)
})
