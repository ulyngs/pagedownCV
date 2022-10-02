#' Take a comma-separated string of authors and replace the first names with an initial and a dot
#'
#' @param authors A comma-separated string of authors (e.g., "Ulrik Lyngs, Kai Lukoff")
#' @inheritParams stringr::str_trim
#' @inheritParams purrr::map
#' @inheritParams purrr::map_chr
#'
#' @return When given "Ulrik Lyngs, Kai Lukoff" it returns "U. Lyngs, K. Lukoff"
#' @export
#'
#' @examples
#' replace_first_names_in_author_list_with_initial_and_dot("Ulrik Lyngs, Kai Lukoff")
#'
replace_first_name_with_initial_and_dot <- function(author_name) {
  str_replace(author_name, "(?<=\\S)\\S+", "\\.")
}

replace_first_names_in_author_list_with_initial_and_dot <- function(authors){
  authors_split <- str_split(authors, ",") %>%
    map(str_trim)

  authors_split[[1]] %>% map_chr(replace_first_name_with_initial_and_dot) %>%
    paste0(collapse = ", ")
}
