reverse_strings <- function(x) {
  sapply(lapply(strsplit(x, NULL), rev), paste, collapse="")
}

paste_names <- function (x) {
  x <- paste0("'", paste0(x, collapse = "', '"), "'")
  x <- sub(",(?= '\\w+'$)", " and", x, perl = TRUE)
  x
}
