
#' Is jg_ModelCode
#'
#' Tests whether x is an object of class \code{\link{jg_ModelCode}}.
#'
#' @param x The object to test.
#' @return A flag indicating whether the test was positive.
#' @export
is.jg_ModelCode <- function(x) {
  inherits(x, "R6") && inherits(x, "jg_ModelCode")
}

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
jg_ModelCode <- R6Class(
  "jg_ModelCode",
  public = list(
    initialize = function(model = "", prediction = "", CurrentState = DefaultState){
      private$vmodel <- model
      private$vprediction <- prediction
      private$StateStack <- state_stack_class$new(CurrentState)
    },
    generate_code = function(x) {
      self$clear()
      ModelLines <- strsplit(x,"\\n")
      ModelLines <- ModelLines[[1]]
      for(line in 1:length(ModelLines)){
        CurLine <- ModelLines[line]
        self$append_line(CurLine) 
      }
      private$StateStack <<- state_stack_class$new(DefaultState)
    },
    clear = function(){
      private$vmodel <<- ""
      private$vprediction <<- ""
      private$StateStack <<- state_stack_class$new(DefaultState)
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
    StateStack = NULL,
  
  up_scope_update = function(CurLine){
    braces <- findInString("\\{",CurLine)
    if(braces>0){
      for(i in 1:braces){ private$StateStack$push() }
    }
  },
  down_scope_update = function(CurLine){
    braces <- findInString("\\}",CurLine)
    if(braces>0){
      for(i in 1:braces){ private$StateStack$pop() }
    }
  },
  get_command_string = function(CurLine){
    CommandString <- stringr::str_match(CurLine,RegStr)
    CommandString
  },
  update_state = function(CommandString){
    if(findInString("P|M",CommandString)>0) {
      NewState <- 0L
      if(findInString("P",CommandString)>0) { NewState <- NewState+PredictionFlag }
      if(findInString("M",CommandString)>0) { NewState <- NewState+ModelFlag }
      private$StateStack$State <<-NewState
    }
  },
  update_code = function(CurLine,CommandString) {
    
    pline <- any(findInString("p",CommandString)>0)
    mline <- any(findInString("m",CommandString)>0)
    
    pstate <-any(bitwAnd(as.integer(private$StateStack$State),PredictionFlag) > 0)
    mstate <- any(bitwAnd(as.integer(private$StateStack$State),ModelFlag)>0)
    
    stateline <- pline|mline
    
    if(pline | (!stateline & pstate)) {
      private$vprediction <<- paste(private$vprediction,paste(CurLine,"\n"))
    }
    if(mline | (!stateline & mstate)) {
      private$vmodel <<- paste(private$vmodel,paste(CurLine,"\n"))
    }
  }),
  active = list(
    model = function() {
      private$vmodel
    },
    prediction = function() {
      private$vprediction
    }
    )
)

findInString <- function(Character,String){
  logical <- sum(grepl(Character,String))
  logical
}
