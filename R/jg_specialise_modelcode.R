
#' Generate the prediction and model versions of the Model_Code
#'
#' @param x is Super Model Code to replicate
#' @export
#' 
jg_specialise_modelcode <- function(x) {
 
  model_code_obj <- jg_ModelCode$new()
  model_code_obj$generate_code(x)
  model_code_obj
}
