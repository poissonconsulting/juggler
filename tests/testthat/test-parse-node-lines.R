context("parse-node-lines")

test_that("jg_extract_modelcode_fragment", {
  expect_equal(jg_extract_modelcode_fragment("b ~ d"), 
                   jg_ModelCodeFragment$new(whole = "b ~ d", variable_name = "b", operator = "~", expression = "d", comment = ""))
  
  expect_equal(jg_extract_modelcode_fragment("b ~ d #Comment"), 
               jg_ModelCodeFragment$new(whole = "b ~ d #Comment", variable_name = "b", operator = "~", expression = "d ", comment = "#Comment"))
  
  expect_equal(jg_extract_modelcode_fragment("b <- d"), 
                   jg_ModelCodeFragment$new(whole = "b <- d", variable_name = "b", operator = "<-", expression = "d", comment = ""))
  
  expect_equal(jg_extract_modelcode_fragment("b <- d #Comment"), 
               jg_ModelCodeFragment$new(whole = "b <- d #Comment", variable_name = "b", operator = "<-", expression = "d ", comment = "#Comment"))
  
  expect_equal(jg_extract_modelcode_fragment("b[i] <- d #Comment"), 
               jg_ModelCodeFragment$new(whole = "b[i] <- d #Comment", variable_name = "b[i]", operator = "<-", expression = "d ", comment = "#Comment"))
  
  expect_equal(jg_extract_modelcode_fragment("b[2*i] <- d #Comment"), 
               jg_ModelCodeFragment$new(whole = "b[2*i] <- d #Comment", variable_name = "b[2*i]", operator = "<-", expression = "d ", comment = "#Comment"))
  
})
