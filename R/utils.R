. <- NULL

collapse_vector_to_string <- function(x) paste0(x, collapse = "\n")

get_line_number <- function(x, pos = -1L) {
  stopifnot(is.string(x))
  n <- str_sub(x, 1L, pos) %>% str_count("\n") %>% add(1)
  if (identical(str_sub(x, pos, pos), "\n"))
    n %<>% subtract(1)
  n
}

is.string <- function(x) is.character(x) && length(x) == 1 && !is.na(x)
is.flag <- function(x) is.logical(x) && length(x) == 1 && !is.na(x)

paste_names <- function(x, quotes = FALSE) {
  stopifnot(is.flag(quotes))
  x <- paste0("'", paste0(x, collapse = "', '"), "'")
  x <- sub(",(?= '\\w+'$)", " and", x, perl = TRUE)
  x
}

reverse_strings <- function(x)
  sapply(lapply(strsplit(x, NULL), rev), paste, collapse = "")

rm_comments <- function(x) str_replace_all(x, "#[^\n]*", "")

block_name <- function(x, start = 1L, end = -1L) {
  stopifnot(is.string(x))
  
  x <- str_sub(x, start, end) %>% str_replace_all("\\s", "") %>% 
    str_replace("[{]$", "")
  
  if (!x %in% block_names) stop("unrecognised block name '", x, "' on line ", get_line_number(x, start), call. = FALSE)
  x
}

start_of_block <- function(x, start = 1) {
  stopifnot(is.string(x))
  
  loc <- str_sub(x, start) %>% str_locate("^\\s*[A-Za-z]+\\s*[{]") %>%
    as.vector() %>% add(start) %>% subtract(1)
  
  if (any(is.na(loc)))
    stop("expecting start of block on line ", get_line_number(x, start), 
         call. = FALSE)
  loc
}
