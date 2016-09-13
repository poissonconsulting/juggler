context("replicate-model-codes")

model = "model {
  for(i in 1:length(data)) {
y ~ x
}
}"

fragments = c("y ~ 2*x", "y ~ 3*x")

test_that("replicate_model_codes", {
  expect_identical(replicate_model_codes(model,fragments), "")
  
})
  