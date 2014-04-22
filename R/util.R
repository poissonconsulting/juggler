reverse_strings <- function(x) {
  sapply(lapply(strsplit(x, NULL), rev), paste, collapse="")
}
