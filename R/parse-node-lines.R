#' Parse Node Lines
#'
#' @param x to parse.
parse_node_lines <- function(x) {
  check_string(x)
  stopifnot(!any_new_line(x))
  x  %<>% stringr::str_match_all("^\\s*(\\w(?:\\s*\\[[^\\]]+\\])?)\\s*(~|<-)\\s*([^~#(?:<\\-)]+)(#.+)?$")
  x
}
