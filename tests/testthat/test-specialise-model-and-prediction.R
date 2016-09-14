context("specialise-model-and-prediction")

model <- "model{ #PM
for(i in 1:length(data)) { #P
  y <- x^2 
  z <- x^3 
 }
}"

result <- c(" model{ #PM \n } \n"," model{ #PM \n for(i in 1:length(data)) { #P \n   y <- x^2  \n   z <- x^3  \n  } \n } \n")

test_that("specialise_model_and_prediction",{
  expect_identical(specialise_model_and_prediction(model), result)
  })
  
  
  model <- "model{ #PM
for(i in 1:length(data)) { #P
  y <- x^2 #m 
  z <- x^3 
  }
}"

result <- c(" model{ #PM \n   y <- x^2 #m  \n } \n"," model{ #PM \n for(i in 1:length(data)) { #P \n   z <- x^3  \n   } \n } \n")
  
test_that("specialise_model_and_prediction", {
  expect_identical(specialise_model_and_prediction(model), result)
  })
  

model <- "model{
  for(i in 1:length(data)) {
    y <- x^2  
    z <- x^3 
  }
}"

result <- c(" model{ \n   for(i in 1:length(data)) { \n     y <- x^2   \n     z <- x^3  \n   } \n } \n"," model{ \n   for(i in 1:length(data)) { \n     y <- x^2   \n     z <- x^3  \n   } \n } \n")

test_that("specialise_model_and_prediction", {
  expect_identical(specialise_model_and_prediction(model), result)
})


model <- "model{
  for(i in 1:length(data)) {
    y <- x^2 #m  
    z <- x^3 #mp
  }
}"

result <- c(" model{ \n   for(i in 1:length(data)) { \n     y <- x^2 #m   \n     z <- x^3 #mp \n   } \n } \n"," model{ \n   for(i in 1:length(data)) { \n     z <- x^3 #mp \n   } \n } \n")

test_that("specialise_model_and_prediction", {
  expect_identical(specialise_model_and_prediction(model), result)
})