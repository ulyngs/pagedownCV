#' Add a column 'number' that counts entries in order of date -- adds leading zero, and optional a letter
#'
#' @param cv_entries_tibble A tibble that has a column called 'date' which contains dates!
#' @param letter_to_pad A letter that should go in front of the counted entries
#' @inheritParams stringr::str_pad
#' @inheritParams stringr::str_c
#' @inheritParams dplyr::arrange
#' @inheritParams dplyr::mutate
#'
#' @return A tibble with an added 'number' column
#' @export
#'
#' @examples
#' library(dplyr)
#' publications |>
#'   filter(type == "journal article") |>
#'   add_leading_zeroes_and_letter("J")
#'
add_leading_zeroes_and_letter <- function(cv_entries_tibble, letter_to_pad = ""){
  if(nrow(cv_entries_tibble) > 9){
    cv_entries_tibble |>
      dplyr::arrange(date) |>
      dplyr::mutate(number = stringr::str_pad(row_number(), width = 2, side = "left", pad = "0"),
             number = stringr::str_c(letter_to_pad, number)) |>
      dplyr::arrange(desc(date))
  } else {
    cv_entries_tibble |>
      dplyr::arrange(date) |>
      dplyr::mutate(number = stringr::str_pad(row_number(), width = 1, side = "left", pad = "0"),
             number = stringr::str_c(letter_to_pad, number)) |>
      dplyr::arrange(desc(date))
  }
}
