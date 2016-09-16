
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
    initialize = function(model = "", prediction = "", CurrentState = DefaultState, StateStack = list()){
      private$vmodel <- model
      private$vprediction <- prediction
      private$CurrentState <- CurrentState
      private$StateStack <- StateStack
    },
    generate_code = function(x) {
      self$clear()
      ModelLines <- strsplit(x,"\\n")
      for(line in 1:length(ModelLines[[1]])){
        CurLine <- ModelLines[[1]][line]
        self$append_line(CurLine) 
      }
      private$CurrentState <<- DefaultState
      private$StateStack <<- list()
    },
    clear = function(){
      private$vmodel <<- ""
      private$vprediction <<- ""
      private$CurrentState <<- DefaultState
      private$StateStack <<- list()
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
      private$CurrentState <<- 0L
      if(findInString("P",CommandString)>0) { private$CurrentState <<- private$CurrentState+PredictionFlag }
      if(findInString("M",CommandString)>0) { private$CurrentState <<- private$CurrentState+ModelFlag }
    }
  },
  update_code = function(CurLine,CommandString) {
    
    pline <- findInString("p",CommandString)>0
    mline <- findInString("m",CommandString)>0
    
    pstate <-bitwAnd(private$CurrentState,PredictionFlag) > 0
    mstate <- bitwAnd(private$CurrentState,ModelFlag) > 0
    
    stateline <- pline|mline
    
    if(pline | (!stateline & pstate)) {
      private$vprediction <<- paste(private$vprediction,paste(CurLine,"\n"))
    }
    if(mline | (!stateline & mstate)) {
      private$vmodel <<- paste(private$vmodel,paste(CurLine,"\n"))
    }
  },
  push_state = function(){
    private$StateStack[[length(private$StateStack)+1]] <<- private$CurrentState
  },
  pop_state=function(){
    if(length(private$StateStack) > 0){
      private$CurrentState <<- private$StateStack[[length(private$StateStack)]]
      private$StateStack[[length(private$StateStack)]] <<- NULL
    }
  }),
  active = list(
    model = function() {
      private$vmodel
    },
    prediction = function() {
      private$vprediction
    })
)

findInString <- function(Character,String){
  logical <- sum(grepl(Character,String))
  logical
}
