#' Replicate Model_Codes
#'
#' @param x is Super Model Code to replicate
#' @param fragments is Fragments defining different versions of the Model
#' @export
replicate_model_codes <- function(x, fragments = character(0)) {
  check_vector(fragments, "", min_length = 0)
  
  for(i in 1:length(fragments)) {
    
    FragmentComponents = parse_node_lines(fragments[i])
  }
  
  ""
}