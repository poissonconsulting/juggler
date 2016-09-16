

model_code_fragment_class_name <-"Model_Code_Fragment"

#' Model Code Fragment class
#'
#'
#' @field whole entire model code fragment
#' @field variable_name name of variable being assigned to. Includes square brackets and contents
#' @field operator string containing the operator for the model code fragment
#' @field expression string containing the entire expression to be assigned to the variable_name
#' @field comment string containing the comment (or command string for models and predictions)
#' @export
frag_class <- R6Class(
  model_code_fragment_class_name,
  public = list(
    initialize = function(whole,variable_name,operator,expression,comment){
     private$vwhole <- whole
     private$vvariable_name <- variable_name
     private$voperator <- operator
     private$vexpression <-expression
     private$vcomment <-comment
    },
    is_match = function(fragment){
      "Checks whether the Model Code Fragment supplied is a matching fragment. Just checks variable_name"
      if(class(fragment) != model_code_fragment_class_name)
        stop(paste(model_code_fragment_class_name," is required type for method matches"))
      result <- fragment$vvariable_name == vvariable_name
      result
    },
    
    is_valid  = function(){
      "returns a logical value representing if this is a valid Model Code Fragment"
      result <- !is.na(vwhole)
      result
    },
    
    has_comment = function(){
      "returns a logical value representing if this contains a valid comment field"
      result <- !is.na(vcomment)
      result
    }),
  private = list(
    vwhole = NULL,
    vvariable_name = NULL,
    voperator = NULL,
    vexpression = NULL,
    vcomment =  NULL),
  active = list(
    comment = function(){
      vcomment
    },
    whole = function(){
      vwhole
    },
    variable_name = function(){
      vvariable_name
    },
    expression = function(){
      vexpression
    },
    operator = function(){
      voperator
    })
)
