context("check-string")

test_that("check_string returns same string", {
  expect_identical(check_string("()"), "()")
  expect_identical(check_string("())))))))"), "())))))))")
})

test_that("check_string collapses character string", {
  expect_warning(x <- check_string(c("(",")")))
  expect_identical(x, "(\n)")
})

test_that("check_string error if not character vector", {
  expect_error(check_string(factor("(")))
})
