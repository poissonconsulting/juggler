context("block names")

test_that("jg_blk_names gets correct names", {
  
  expect_identical(jg_blk_names("model {}"), "model")
  expect_identical(jg_blk_names("model{}"), "model")
  expect_identical(jg_blk_names("model{}data{}"), c("model","data"))
  expect_identical(jg_blk_names("data{} model{}"), c("data","model"))
  expect_identical(jg_blk_names("model{{x <- bt[1:2]}} data{}"), c("model","data"))
  expect_identical(jg_blk_names("settings{} \n\ndata{} model{}"), c("settings","data","model"))
  expect_identical(jg_blk_names("data {X <- 2} model { Y ~ }"),c("data","model"))
  expect_identical(jg_blk_names("data{X <- 2} model{ Y ~ dpois(X) }"), c("data","model"))
})
