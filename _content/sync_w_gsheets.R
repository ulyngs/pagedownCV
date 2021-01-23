library(tidyverse)
library(googlesheets4)
gs4_deauth()

sheets <- c("cv_entries", 
            "publications")

store_sheet_in_csv <- function(sheet_name){
  read_sheet("https://docs.google.com/spreadsheets/d/1ta71CAGkcLqm-W1UdVRA_JJSddWV2TsrRZsCnQlmOis/edit?usp=sharing",
             sheet = sheet_name, col_types = c("c")) %>% 
    write_csv(here::here(str_c("_content/", sheet_name, ".csv")))
}

walk(sheets, store_sheet_in_csv)