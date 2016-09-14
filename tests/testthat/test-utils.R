context("utils")

test_that("block_name", {
  expect_identical(block_name("model{"), "model")
  expect_identical(block_name("model  {"), "model")
  expect_identical(block_name("xmodel", 2), "model")
  
  expect_error(block_name("data2"), "unrecognised block name 'data2' on line 1")
})

test_that("get_line_number", {
  expect_identical(get_line_number("\n"), 1)
  expect_identical(get_line_number("\n\n"), 2)
  expect_identical(get_line_number("a"), 1)
  expect_identical(get_line_number("ab"), 1)
  expect_identical(get_line_number("ab\n"), 1)
  expect_identical(get_line_number("ab\n\n"), 2)
  expect_identical(get_line_number("ab\n\n", 2), 1)
})

test_that("paste_names", {
  expect_identical(paste_names(NULL), "''")
  expect_identical(paste_names(character(0)), "''")
  expect_identical(paste_names(1), "'1'")
  expect_identical(paste_names(1:2), "'1' and '2'")
  expect_identical(paste_names(1:3), "'1', '2' and '3'")
})

test_that("rm_comments", {
  expect_identical(rm_comments("x#1\ny#2"), "x\ny")
  expect_identical(rm_comments("x#1\ny#2"), "x\ny")
  expect_identical(rm_comments("#"), "")
  expect_identical(rm_comments("#1#"), "")
  expect_identical(rm_comments("(#)"), "(")
  expect_identical(rm_comments("#\n#1"), "\n")
})

test_that("reverse_strings", {
  expect_identical(reverse_strings("abc"), "cba")
  expect_identical(reverse_strings(c("abc","def")), c("cba","fed"))
  expect_identical(reverse_strings(c("ab c","def")), c("c ba","fed"))
})

test_that("start_of_block", {
  expect_identical(start_of_block("model{"), c(1,6))
  expect_identical(start_of_block("data{}model{}"), c(1,5))
  expect_identical(start_of_block("data{}model{}", 7), c(7,12))
  expect_identical(start_of_block("data{} model{}", 7), c(7,13))
  expect_identical(start_of_block("data{} model{}", 8), c(8,13))

  expect_error(start_of_block("data"), "expecting start of block on line 1")
  expect_error(start_of_block("data{\n}\n model", 10), "expecting start of block on line 3")
})
