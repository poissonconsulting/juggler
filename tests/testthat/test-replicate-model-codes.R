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

result <-" model { 
   for(i in 1:length(data)) { 
 y ~ 2*x  
 z ~ 3*x  
 } 
 } 
" 

result1 <- c(" model{ #PM \n z[i] <- x^3 #mp \n } \n",
  " model{ #PM \n for(i in 1:length(data)) { #P \n y[i] <- x[i]^2  \n z[i] <- x^3 #mp \n } \n } \n")


result2 <- c("  model{ #PM  \n  z[i] <- x^3 #mp  \n  }  \n",
             "  model{ #PM  \n  for(i in 1:length(data)) { #P  \n  y[i] <- x[i]^2   \n  z[i] <- x^3 #mp  \n  }  \n  }  \n")


result3 <- c("  model{ #PM  \n  z[i] <- x^3 #mp  \n  }  \n",
             "  model{ #PM  \n  for(i in 1:length(data)) { #P  \n  y[i] <- x[i]^2   \n  z[i] <- x^3 #mp  \n  }  \n  }  \n")

result4 <- c("  model{ #PM  \n  z[i] <- x^3 #mp  \n  }  \n",
             "  model{ #PM  \n  for(i in 1:length(data)) { #P  \n  y[i] <- x[i]^2   \n  z[i] <- x^3 #mp  \n  }  \n  }  \n")


result <- list(result1,result2,result3,result4)

test_that("test_replicate_model_codes", {
  expect_identical(replicate_model_codes(model,fragments), result)
  })
  