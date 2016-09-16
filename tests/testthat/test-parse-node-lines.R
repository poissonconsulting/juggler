context("parse-node-lines")

test_that("parse_node_lines", {
  expect_equal(parse_node_lines("b ~ d"), 
                   frag_class$new(whole = "b ~ d", variable_name = "b", operator = "~", expression = "d", comment = ""))
  
  expect_equal(parse_node_lines("b ~ d #Comment"), 
               frag_class$new(whole = "b ~ d #Comment", variable_name = "b", operator = "~", expression = "d ", comment = "#Comment"))
  
  expect_equal(parse_node_lines("b <- d"), 
                   frag_class$new(whole = "b <- d", variable_name = "b", operator = "<-", expression = "d", comment = ""))
  
  expect_equal(parse_node_lines("b <- d #Comment"), 
               frag_class$new(whole = "b <- d #Comment", variable_name = "b", operator = "<-", expression = "d ", comment = "#Comment"))
  
  expect_equal(parse_node_lines("b[i] <- d #Comment"), 
               frag_class$new(whole = "b[i] <- d #Comment", variable_name = "b[i]", operator = "<-", expression = "d ", comment = "#Comment"))
  
  expect_equal(parse_node_lines("b[2*i] <- d #Comment"), 
               frag_class$new(whole = "b[2*i] <- d #Comment", variable_name = "b[2*i]", operator = "<-", expression = "d ", comment = "#Comment"))
  
})
