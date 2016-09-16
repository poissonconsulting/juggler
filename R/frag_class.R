

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
      result <- all(fragment$variable_name == private$vvariable_name)
      result
    },
    
    is_valid  = function(){
      "returns a logical value representing if this is a valid Model Code Fragment"
      result <- !is.na(private$vwhole)
      result
    },
    
    has_comment = function(){
      "returns a logical value representing if this contains a valid comment field"
      result <- !is.na(private$vcomment)
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
      private$vcomment
    },
    whole = function(){
      private$vwhole
    },
    variable_name = function(){
      private$vvariable_name
    },
    expression = function(){
      private$vexpression
    },
    operator = function(){
      private$voperator
    })
)
