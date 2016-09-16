#' Generate a single version of a Model_Code
#'
#' @param x is Super Model Code to replicate
#' @param fragments is Fragments defining different versions of the Model
#' @export
generate_model_code_version <- function(x, fragments) {
  
  FragmentComponents <- extract_fragment_components(fragments)
  Output <- process_code_lines(x,FragmentComponents)
  Output
}

extract_fragment_components <- function(fragments){
  FragmentComponents <- list()
  
  for(i in 1:length(fragments)) {
    FragmentComponents[[i]] <- parse_node_lines(fragments[[i]])
  }
  FragmentComponents
}

process_code_lines <- function(ModelLines,FragmentComponents){
  ModelLines <- strsplit(ModelLines,"\\n")
  
  Output <- ""
  for(line in 1:length(ModelLines[[1]])) {
    CurLine <- ModelLines[[1]][line]
    LineComponents <- parse_node_lines(CurLine)
    
    if(LineComponents$is_valid()){
      CurLine %<>% replace_matches(LineComponents,FragmentComponents)
    }
    Output <- paste(Output,paste(CurLine,"\n"))
  }
  Output
}

replace_matches <- function(CurLine,LineComponents,FragmentComponents ){
  for(frag in 1:length(FragmentComponents))
  {
    ThisFrag <- FragmentComponents[[frag]]
    if(LineComponents$is_match(ThisFrag))
    {
      CurLine <- ThisFrag$whole
      
      if(LineComponents$has_comment()) {
        CurLine <- paste(CurLine,LineComponents$comment)
      }
      return(CurLine)
    }
  }
  CurLine
}