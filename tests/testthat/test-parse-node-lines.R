context("parse-node-lines")

test_that("parse_node_lines", {
  expect_identical(parse_node_lines("b ~ d"), 
                   list(matrix(c("b ~ d", "b", "~", "d"), nrow = 1)))
  
  expect_identical(parse_node_lines("b ~ d"), 
                   list(matrix(c("b ~ d", "b", "~", "d"), nrow = 1)))
  
})
  