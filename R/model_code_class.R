
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
#' @export
model_code_class <- setRefClass(model_code_class_name,
                          fields = list(
                            model = "character",
                            prediction = "character",
                            StateStack = "list",
                            CurrentState = "numeric"),
                          methods = list(
                            generate_code = function(x)
                            {
                              initialise()
                              ModelLines <- strsplit(x,"\\n")
                              for(line in 1:length(ModelLines[[1]])){
                                CurLine <- ModelLines[[1]][line]
                                append_line(CurLine) 
                              }
                              
                            },
                            initialise = function(){
                              model <<- ""
                              prediction <<- ""
                              CurrentState <<- DefaultState
                              StateStack[[1]] <<- DefaultState
                            },
                            append_line = function(CurLine){
                              up_scope_update(CurLine)
                              CommandString <- get_command_string(CurLine)
                              update_state(CommandString)
                              update_code(CurLine,CommandString)
                              down_scope_update(CurLine)
                            },
                            up_scope_update = function(CurLine){
                              braces <- findInString("\\{",CurLine)
                                 for(i in 1:braces){ push_state() 
                                   }
                            },
                            down_scope_update = function(CurLine){
                              braces <- findInString("\\}",CurLine)
                              for(i in 1:braces){ pop_state() }
                            },
                            get_command_string = function(CurLine){
                              CommandString <- stringr::str_match(CurLine,RegStr)
                              CommandString
                            },
                            update_state = function(CommandString){
                              if(findInString("P|M",CommandString)) {
                                CurrentState <<- EmptyFlag
                                if(findInString("P",CommandString)) { CurrentState <<- CurrentState+PredictionFlag }
                                if(findInString("M",CommandString)) { CurrentState <<- CurrentState+ModelFlag }
                              }
                            },
                            update_code = function(CurLine,CommandString) {
                              if(findInString("p",CommandString) || bitwAnd(CurrentState,PredictionFlag)>0) {
                                prediction <<- paste(prediction,paste(CurLine,"\n"))
                              }
                              if(findInString("m",CommandString) || bitwAnd(CurrentState,ModelFlag) > 0) {
                                model <<- paste(model,paste(CurLine,"\n"))
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
                            }
                            )
)


findInString <- function(Character,String){
  logical <- sum(grepl(Character,String))
  logical
}
