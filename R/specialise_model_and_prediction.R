
#' Generate the prediction and model versions of the Model_Code
#'
#' @param x is Super Model Code to replicate
#' @export
#' 
specialise_model_and_prediction <- function(x) {
  
  RegStr = "#([pmaPMA]+)"
  
  StateStack <- c("")
  CurrentState <- ""
  
  ModelLines <- strsplit(x,"\\n")
  
  Model <-""
  Prediction <-""
  
  for(line in 1:length(ModelLines[[1]])){
    CurLine <- ModelLines[[1]][line]
    
    CommandString <- stringr::str_match(CurLine,RegStr)
    
    Done <- FALSE;
    
    if(findInString("p",CommandString)) {
      Prediction <- paste(Prediction,paste(CurLine,"\n"))
      Done <- TRUE
    }
    
    if(findInString("m",CommandString)) {
      Model <- paste(Model,paste(CurLine,"\n"))
      Done <- TRUE
    }
    
    if(findInString("\\{",CurLine)){
     StateStack %<>% pushR(CurrentState) 
    }

    if(!Done) {
      if(findInString("P|M",CommandString)) {
        CurrentState = ""

        if(findInString("P",CommandString)) {
          CurrentState <- paste(CurrentState,"P");
        }

        if(findInString("M",CommandString)) {
            CurrentState <- paste(CurrentState,"M");
        }

      }

      if(findInString("P",CurrentState)) {
        Prediction <- paste(Prediction,paste(CurLine,"\n"))
      }

      if(findInString("M",CurrentState)) {
        Model <- paste(Model,paste(CurLine,"\n"))
      }
    }
    
    if(findInString("\\}",CurLine)){
      CurrentState <- popR(StateStack) 
    }
  }
  
  return_var <- c(Model, Prediction)
  return_var
}

findInString <- function(Character,String){
  logical <- any(grepl(Character,String))
  logical
}

pushR = function(foo, bar){
  foo[[length(foo)+1]] <- bar
  foo
}

popR=function(foo){
  foo[[length(foo)]]
}