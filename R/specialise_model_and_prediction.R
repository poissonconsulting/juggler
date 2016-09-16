
#' Generate the prediction and model versions of the Model_Code
#'
#' @param x is Super Model Code to replicate
#' @export
#' 
specialise_model_and_prediction <- function(x) {
 
  model_code_obj <- model_code_class$new()
  model_code_obj$generate_code(x)
  model_code_obj
}
