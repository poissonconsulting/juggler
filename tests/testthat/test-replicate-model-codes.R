context("replicate-model-codes")

model <- "model{ #PM
for(i in 1:length(data)) { #P
y[i] <- x[i]^2 
z[i] <- x^3 #mp
}
}" 

fragments1 <- c("y <- x", "z <- x*2")
fragments2 <- c("y <- x+1", "z <- x*2+1")
fragments3 <- c("z <- x*2+1")
fragments <- list(fragments1,fragments2,fragments3)

result1 <- model_code_class$new(model = " model{ #PM \n z[i] <- x^3 #mp \n } \n",
  prediction = " model{ #PM \n for(i in 1:length(data)) { #P \n y[i] <- x[i]^2  \n z[i] <- x^3 #mp \n } \n } \n")

result2 <- model_code_class$new(model = "  model{ #PM  \n  z[i] <- x^3 #mp  \n  }  \n",
  prediction = "  model{ #PM  \n  for(i in 1:length(data)) { #P  \n  y[i] <- x[i]^2   \n  z[i] <- x^3 #mp  \n  }  \n  }  \n")

result3 <- model_code_class$new(model = "  model{ #PM  \n  z[i] <- x^3 #mp  \n  }  \n",
  prediction = "  model{ #PM  \n  for(i in 1:length(data)) { #P  \n  y[i] <- x[i]^2   \n  z[i] <- x^3 #mp  \n  }  \n  }  \n")

result4 <- model_code_class$new(model = "  model{ #PM  \n  z[i] <- x^3 #mp  \n  }  \n",
  prediction = "  model{ #PM  \n  for(i in 1:length(data)) { #P  \n  y[i] <- x[i]^2   \n  z[i] <- x^3 #mp  \n  }  \n  }  \n")

result <- list(result1,result2,result3,result4)

test_that("test_replicate_model_codes", {
  expect_equal(replicate_model_codes(model,fragments), result)
  })
  