#' Non-publication entries from Ulrik Lyngs' CV
#'
#' @format A tibble with 129 rows and 18 variables:
#' \describe{
#'   \item{type}{chr The type of entry. E.g., research_positions, education, awards, ...}
#'   \item{year}{chr A string of the year (e.g. "2020"), or year span (e.g., "2021 --- present") for the entry}
#'   \item{date}{date The (start) date of the entry}
#'   \item{date_end}{chr The end date of the entry, if relevant. The end date might be "present"}
#'   \item{what}{chr A description of what the entry is }
#'   \item{what_translation}{chr An optional translation of the 'what' into English }
#'   \item{institution}{chr The institution where the entry took place }
#'   \item{department}{chr The department where the entry took place }
#'   \item{where}{chr Generic 'where' the entry took place }
#'   \item{additional_info}{chr Any other potentially relevant information }
#'   \item{additional_info2}{chr Any other potentially relevant information }
#'   \item{url}{chr Relevant hyperlink for the entry }
#'   \item{slides}{chr URL to slides for the entry (e.g., presentation slides) }
#'   \item{video}{chr URL to video for the entry }
#'   \item{one_column_paged, carlsberg, exclude}{chr Columns used to include or exclude particular entries for the use of specific CV versions }
#' }
#' @source \url{https://docs.google.com/spreadsheets/d/1ta71CAGkcLqm-W1UdVRA_JJSddWV2TsrRZsCnQlmOis/edit?usp=sharing}
"cv_entries"
