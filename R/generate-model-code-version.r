#' Generate a single version of a Model_Code
#'
#' @param x is Super Model Code to replicate
#' @param fragments is Fragments defining different versions of the Model
#' @export
generate_model_code_version <- function(x, fragments) {
  check_vector(fragments, "", min_length = 0)

  FragmentComponents <- vector("list",length(fragments))

  for(i in 1:length(fragments)) {
    FragmentComponents[i] <- parse_node_lines(fragments[[i]])
  }

  Output <- ""
  ModelLines <- strsplit(x,"\\n")

  for(line in 1:length(ModelLines[[1]])) {
      CurLine <- ModelLines[[1]][line]
      LineComponents <- parse_node_lines(CurLine)
      if(!is.na(LineComponents[[1]][1])) {
        for(frag in 1:length(FragmentComponents))
          {
          if(FragmentComponents[[frag]][2] == LineComponents[[1]][2])
          {
            CurLine <- FragmentComponents[[frag]][1]
            break
          }
        }
      }
      
      if(is.na(LineComponents[[1]][5])) {
        Output <- paste(Output,paste(CurLine,"\n"))
      }
      else {
        Output <- paste(Output,paste(CurLine,paste(LineComponents[[1]][5],"\n")))
      }
    }
  Output
}
