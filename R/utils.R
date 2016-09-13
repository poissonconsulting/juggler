any_new_line <- function(x) stringr::str_detect(x, "\\n")
any_comment <- function(x) stringr::str_detect(x, "#")
