#' Turn the year into an empty string when it's the same year as the previous entry
#'
#' @param cv_entry_tibble A tibble with a column called 'year' that contains years...
#' @inheritParams dplyr::mutate
#' @inheritParams dplyr::row_number
#' @inheritParams dplyr::lag
#' @inheritParams dplyr::select
#'
#' @return A tibble with an added 'number' column
#' @export
#'
#' @examples
#' publications |>
#'   filter(type == "journal article") |>
#'   blank_year_when_repeated()
#'
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
