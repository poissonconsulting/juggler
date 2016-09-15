

model_code_fragment_class_name <-"Model_Code_Fragment"

#' Model Code Fragment class
#'
#' @export
frag_class <- setRefClass(model_code_fragment_class_name,
                          fields = list(
                            whole = "character",
                            variable_name = "character",
                            operator = "character",
                            expression = "character",
                            comment =  "character"),
                          methods = list(
                            is_match = function(fragment){
                              if(class(fragment) != model_code_fragment_class_name)
                                stop(paste(model_code_fragment_class_name," is required type for method matches"))
                              result <- fragment$variable_name == variable_name
                              result
                             },
                            is_valid  = function(){
                              result <- !is.na(whole)
                              result
                            },
                            has_comment = function(){
                              result <- !is.na(comment)
                              result
                            })
)