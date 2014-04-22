context("pass_brackets")

test_that("pass_brackets works on paired brackets", {
  expect_equivalent(pass_brackets("()", 1), 2)
  expect_equivalent(pass_brackets("(())", 1), 4)
  expect_equivalent(pass_brackets("((({})))",1), 8)
  expect_equivalent(pass_brackets("()()", 1), 2)
  expect_equivalent(pass_brackets("()()", 3), 4)
  expect_equivalent(pass_brackets("([])()", 1), 4)
  expect_equivalent(pass_brackets("())))))))", 1), 2)
})

test_that("pass_brackets named by brackets", {
  expect_equivalent(names(pass_brackets("()", 1)), "()")
  expect_equivalent(names(pass_brackets("(())", 1)), "(())")
  expect_equivalent(names(pass_brackets("((({})))",1)), "((({})))")
  expect_equivalent(names(pass_brackets("()()", 1)), "()")
  expect_equivalent(names(pass_brackets("()()", 3)), "()")
  expect_equivalent(names(pass_brackets("([ \n ])()", 1)), "([ \n ])")
  expect_equivalent(names(pass_brackets("())))))))", 1)), "()")
  expect_equivalent(names(pass_brackets("name[index1[index2[i]]]", 5)), "[index1[index2[i]]]")
  expect_equivalent(names(pass_brackets("name[index1[index2 [ i ]]]", 5)), "[index1[index2 [ i ]]]")
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

test_that("pass_brackets fails wrong starting point", {
  expect_error(pass_brackets("x()", 1))
  expect_error(pass_brackets("x()", 3))
})
  