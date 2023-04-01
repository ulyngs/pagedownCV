# add a column 'number' that counts entries in order of date -- adds leading zero, and optionally a letter
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


# Turn year into an empty string when it's the same year as the previous entry
blank_year_when_repeated <- function(cv_entry_tibble){
  cv_entry_tibble |>
    dplyr::mutate(row_number = dplyr::row_number()) |>
    dplyr::mutate(year = as.character(year),
                  year = dplyr::case_when(
                    row_number == 1 ~ year,
                    year == dplyr::lag(year) ~ "",
                    year != dplyr::lag(year) ~ year
                  )) %>%
    select(-row_number)
}


# Adds a page break after a row in a column that contains a specified text
# publications |>
#  manual_page_break_after_row("title", "Before and after GDPR")
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


#' Take an author name and replace the first name with an initial and dot
#' e.g. When given "Ulrik Lyngs" it returns "U. Lyngs"
replace_first_name_with_initial_and_dot <- function(author_name) {
  stringr::str_replace(author_name, "(?<=\\S)\\S+", "\\.")
}


#' Take a comma-separated string of authors and replace the first names with an initial and a dot
# When given "Ulrik Lyngs, Kai Lukoff" it returns "U. Lyngs, K. Lukoff"
replace_first_names_in_author_list_with_initial_and_dot <- function(authors){
  authors_split <- stringr::str_split(authors, ",") %>%
    map(stringr::str_trim)

  authors_split[[1]] %>% purrr::map_chr(replace_first_name_with_initial_and_dot) %>%
    paste0(collapse = ", ")
}
