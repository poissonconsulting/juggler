context("utils")

test_that("any_new_line", {
  
  expect_true(any_new_line("\n"))
  expect_true(any_new_line("a \n"))
  expect_true(any_new_line("\n z"))
  expect_false(any_new_line(""))
  expect_false(any_new_line("a z"))
  expect_false(any_new_line(1))
})

test_that("any_comment", {
  expect_true(any_comment("#"))
  expect_true(any_comment("a #"))
  expect_true(any_comment("# z"))
  expect_false(any_comment(""))
  expect_false(any_comment("a z"))
  expect_false(any_comment(1))
})
