#' save my google sheet as an excel file
library(openxlsx)
library(googlesheets4)
gs4_deauth()

# the link to my CV on google sheets
my_cv_url <- "https://docs.google.com/spreadsheets/d/1ta71CAGkcLqm-W1UdVRA_JJSddWV2TsrRZsCnQlmOis/edit?usp=sharing"

# read in the two tabs we want
cv_entries <- read_sheet(my_cv_url, sheet = "cv_entries")
publications <- read_sheet(my_cv_url, sheet = "publications")

# write it to an excel file
write.xlsx(list("cv_entries" = cv_entries, "publications" = publications), "cv_data.xlsx")

