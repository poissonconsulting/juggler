context("replicate-model-codes")

model <- "model {
  for(i in 1:length(data)) {
y ~ x^2
z ~ x^3
}
}"

fragments <- c("y ~ 2*x", "z ~ 3*x")

result <-" model { 
   for(i in 1:length(data)) { 
 y ~ 2*x 
 z ~ 3*x 
 } 
 } 
" 
test_that("replicate_model_codes", {
  expect_identical(replicate_model_codes(model,fragments), result)
  
})
  