
model_code_class_name <-"Model_Code"

RegStr = "#([pmaPMA]+)"

EmptyFlag <- 0L
PredictionFlag <- 1L
ModelFlag <- 2L
AggregateFlag <- 4L

AllFlag <- (2^31)-1

DefaultState <- AllFlag

#' Model Code class
#'
#' @field model Contains a string representation of the vmodel version of the Model Code
#' @field prediction Contains a string representation of the vprediction version of the Model Code
#' @export
model_code_class <- R6Class(
  model_code_class_name,
  public = list(
    initialize = function(model = "", prediction = ""){
      private$vmodel <- model
      private$vprediction <- prediction
      private$CurrentState <- DefaultState
      private$StateStack <- list()
    },
    generate_code = function(x) {
      self$clear()
      ModelLines <- strsplit(x,"\\n")
      for(line in 1:length(ModelLines[[1]])){
        CurLine <- ModelLines[[1]][line]
        self$append_line(CurLine) 
      }
      CurrentState <<- DefaultState
      StateStack <<- list()
    },
    clear = function(){
      vmodel <<- ""
      vprediction <<- ""
      CurrentState <<- DefaultState
      StateStack <<- list()
    },
    append_line = function(CurLine){
      private$up_scope_update(CurLine)
      CommandString <- private$get_command_string(CurLine)
      private$update_state(CommandString)
      private$update_code(CurLine,CommandString)
      private$down_scope_update(CurLine)
    }),
  
  private = list(
    vmodel = "",
    vprediction = "",
    StateStack = list(),
    CurrentState = DefaultState,
  
  up_scope_update = function(CurLine){
    braces <- findInString("\\{",CurLine)
    if(braces>0){
      for(i in 1:braces){ private$push_state() }
    }
  },
  down_scope_update = function(CurLine){
    braces <- findInString("\\}",CurLine)
    if(braces>0){
      for(i in 1:braces){ private$pop_state() }
    }
  },
  get_command_string = function(CurLine){
    CommandString <- stringr::str_match(CurLine,RegStr)
    CommandString
  },
  update_state = function(CommandString){
    if(findInString("P|M",CommandString)>0) {
      CurrentState <<- 0L
      if(findInString("P",CommandString)>0) { CurrentState <<- CurrentState+PredictionFlag }
      if(findInString("M",CommandString)>0) { CurrentState <<- CurrentState+ModelFlag }
    }
  },
  update_code = function(CurLine,CommandString) {
    
    pline <- findInString("p",CommandString)>0
    mline <- findInString("m",CommandString)>0
    
    pstate <-bitwAnd(CurrentState,PredictionFlag) > 0
    mstate <- bitwAnd(CurrentState,ModelFlag) > 0
    
    stateline <- pline|mline
    
    if(pline | (!stateline & pstate)) {
      vprediction <<- paste(vprediction,paste(CurLine,"\n"))
    }
    if(mline | (!stateline & mstate)) {
      vmodel <<- paste(vmodel,paste(CurLine,"\n"))
    }
  },
  push_state = function(){
    StateStack[[length(StateStack)+1]] <<- CurrentState
  },
  pop_state=function(){
    if(length(StateStack) > 0){
      CurrentState <<- StateStack[[length(StateStack)]]
      StateStack[[length(StateStack)]] <<- NULL
    }
  }),
  active = list(
    model = function() {
      vmodel
    },
    prediction = function() {
      vprediction
    })
)

findInString <- function(Character,String){
  logical <- sum(grepl(Character,String))
  logical
}
