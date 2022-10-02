#' Adds a page break after a row that contains a specified text
#'
#' @param some_tibble A tibble
#' @param a_column_name The name of the column where you'd like to detect text
#' @param text_to_detect The text you'd like to detect -- a page break is added by the end of the rows with this text
#' @param use_glue Whether to have the output be of type glue/character (default), or character
#' @inheritParams glue::glue
#' @inheritParams stringr::str_detect
#' @inheritParams dplyr::mutate
#'
#' @return A tibble with a page break added by the end of specified
#' @export
#'
#' @examples
#' # add page break after the GDPR paper
#' publications |>
#'  filter(type == "journal article") |>
#'  mutate(citation = glue::glue("{title}, {year}")) |>
#'  select(year, citation) |>
#'  manual_page_break_after_row("citation", "Before and after GDPR")
#'
manual_page_break_after_row <- function(some_tibble, a_column_name, text_to_detect, use_glue = TRUE){
  if(use_glue){
    some_tibble |>
      dplyr::mutate({{a_column_name}} := if_else(stringr::str_detect(.data[[a_column_name]], text_to_detect),
                                          glue::glue("{.data[[a_column_name]]} <br class='pageBreak'>"),
                                          glue::glue("{.data[[a_column_name]]}")
      ))
  } else {
    some_tibble |>
      dplyr::mutate({{a_column_name}} := if_else(stringr::str_detect(.data[[a_column_name]], text_to_detect),
                                          paste(.data[[a_column_name]], "<br class='pageBreak'>"),
                                          paste(.data[[a_column_name]])
      ))
  }
}
