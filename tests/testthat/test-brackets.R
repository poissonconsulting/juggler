context("pass_brackets")

test_that("pass_brackets works on paired brackets", {
  expect_identical(pass_brackets("()", 1), 2)
  expect_identical(pass_brackets("(())", 1), 4)
  expect_identical(pass_brackets("((({})))",1), 8)
  expect_identical(pass_brackets("()()", 1), 2)
  expect_identical(pass_brackets("()()", 3), 4)
  expect_identical(pass_brackets("([])()", 1), 4)
  expect_identical(pass_brackets("())))))))", 1), 2)
})

test_that("pass_brackets fails on unpaired brackets", {
  expect_error(pass_brackets("(", 1))
  expect_error(pass_brackets(")", 1))
  expect_error(pass_brackets("", 1))
  expect_error(pass_brackets(NULL, 1))
  expect_error(pass_brackets("(()", 1))
  expect_error(pass_brackets("(})", 1))
  expect_error(pass_brackets("(])", 1))
  expect_error(pass_brackets("(]", 1))
})
