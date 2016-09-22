#' Parse Node Lines
#'
#' @param x to parse.
jg_extract_modelcode_fragment <- function(x) {
  check_string(x)
  stopifnot(!any_new_line(x))
  x %<>% stringr::str_match_all("^\\s*(\\w(?:\\s*\\[[^\\]]+\\])?)\\s*(~|<-)\\s*([^~#(?:<\\-)]+)(#.+)?$")

  modelcode_fragment <-jg_ModelCodeFragment$new(whole = x[[1]][1],
                            variable_name = x[[1]][2],
                            operator = x[[1]][3],
                            expression = x[[1]][4],
                            comment = x[[1]][5])

  modelcode_fragment
}
