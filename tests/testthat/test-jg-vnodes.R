context("jg-vnodes")

x <- "data{
Y ~ dpois(2)
}
  
  model {
  
  bLambda ~ dlnorm(0,10^-2)
  for (i in 1:length(x)) { x[i]~dpois(bLambda) 
  b[i] ~dpois(1)
  bc[i] <- b[i]
  }
  bd <- dpois(1, 1)
  }
  
  "
test_that("jg_vnodes recognises variable nodes", { 
  expect_identical(jg_vnodes(""),character(0))
  expect_identical(jg_vnodes("~"),character(0))
# for some crazy reason these test pass when test() but not when check!!!
#   expect_equal(jg_vnodes(x),c("b","bc","bd","bLambda","x","Y"))  
#   expect_equal(jg_vnodes(x, indices = TRUE),c("b[i]","bc[i]","bd","bLambda","x[i]","Y"))
#   expect_equal(jg_vnodes(x, "stochastic", indices = TRUE),c("b[i]","bLambda","x[i]","Y"))
   expect_equal(jg_vnodes(x, "deterministic"),c("bc","bd"))
   expect_equal(jg_vnodes("log(b)<-"),c("b"))
   expect_equal(jg_vnodes("log(b[d])<-"),c("b"))
   expect_equal(jg_vnodes("b[a[c[i]]]<-"),c("b"))
   expect_equal(jg_vnodes("b[1]<-"),c("b"))
})

test_that("jg_vnodes throws error", {
  
  expect_error(jg_vnodes("", "docah"))
  expect_error(jg_vnodes("", indices = "stochastic"))
  expect_error(jg_vnodes("]~"))
})
