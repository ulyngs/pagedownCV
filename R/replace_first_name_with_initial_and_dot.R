#' Take an author name and replace the first name with an initial and dot
#'
#' @param authors A string with an author name (e.g., "Ulrik Lyngs")
#' @inheritParams stringr::str_replace
#'
#' @return When given "Ulrik Lyngs" it returns "U. Lyngs"
#' @export
#'
#' @examples
#' replace_first_name_with_initial_and_dot("Ulrik Lyngs")
#'
replace_first_name_with_initial_and_dot <- function(author_name) {
  stringr::str_replace(author_name, "(?<=\\S)\\S+", "\\.")
}
