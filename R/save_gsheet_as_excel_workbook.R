#' Read in a public google sheet and save its sheets as a
#'
#' @param gsheet_url A URL to a google sheet. By default uses Ulrik Lyngs' CV google sheet.
#' @param store_path Where to store the downloaded sheet. By default stores it as a CSV file with the same name as the sheet.
#' @inheritParams googlesheets4::gs4_deauth
#' @inheritParams googlesheets4::read_sheet
#' @inheritParams googlesheets4::sheet_names
#' @inheritParams dplyr::rowwise
#' @inheritParams dplyr::mutate
#' @inheritParams tibble::tibble
#' @inheritParams tibble::deframe
#' @inheritParams openxlsx::write.xlsx
#'
#' @return Nothing
#' @export
#'
#' @examples
#' my_gsheet <- "https://docs.google.com/spreadsheets/d/1ta71CAGkcLqm-W1UdVRA_JJSddWV2TsrRZsCnQlmOis/edit?usp=sharing"
#' save_gsheet_as_excel_workbook(my_gsheet, "my_precious.xlsx")
#'
save_gsheet_as_excel_workbook <- function(gsheet_url = "https://docs.google.com/spreadsheets/d/1ta71CAGkcLqm-W1UdVRA_JJSddWV2TsrRZsCnQlmOis/edit?usp=sharing", store_path, publicly_viewable = TRUE){
  if(publicly_viewable){
    googlesheets4::gs4_deauth()
  }

  tibble_w_data <- tibble::tibble(
    sheets = googlesheets4::sheet_names(gsheet_url)
  ) |>
    dplyr::rowwise() |>
    dplyr::mutate(data = list(googlesheets4::read_sheet(gsheet_url, sheet = sheets)))

  tibble_w_data |>
    tibble::deframe() |>
    openxlsx::write.xlsx(file = store_path)
}

