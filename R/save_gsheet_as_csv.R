#' Read in a public google sheet and save it as CSV
#'
#' @param gsheet_url A URL to a google sheet. By default uses Ulrik Lyngs' CV google sheet. Create a link to your own google sheet by clicking the 'Share' button on a google sheet, then create a general access link.
#' @param sheet_name The name of a single sheet within the google sheet
#' @param store_path Where to store the downloaded sheet. By default stores it as a CSV file with the same name as the sheet.
#' @inheritParams googlesheets4::read_sheet
#' @inheritParams googlesheets4::gs4_deauth
#'
#' @return Nothing
#' @export
#'
#' @examples
#' my_gsheet <- "https://docs.google.com/spreadsheets/d/1ta71CAGkcLqm-W1UdVRA_JJSddWV2TsrRZsCnQlmOis/edit?usp=sharing"
#' save_gsheet_as_csv("cv_entries", my_gsheet)
#'
save_gsheet_as_csv <- function(sheet_name, gsheet_url = "https://docs.google.com/spreadsheets/d/1ta71CAGkcLqm-W1UdVRA_JJSddWV2TsrRZsCnQlmOis/edit?usp=sharing", store_path = paste0(sheet_name, ".csv"), publicly_viewable = TRUE){
  if(publicly_viewable){
    googlesheets4::gs4_deauth()
  }
  googlesheets4::read_sheet(gsheet_url,
             sheet = sheet_name,
             col_types = c("c")) |>
    write.csv(store_path)
}
