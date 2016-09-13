context("generate-model-code-version")

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
test_that("test_generate_model_code_version", {
  expect_identical(generate_model_code_version(model,fragments), result)
  
})
  