library(tidyverse)
library(pagedownCV)
library(lubridate)
library(openxlsx)

## uncomment these lines to grab the latest version
# library(googlesheets4)
# gs4_deauth()
#
# store_sheet_in_csv <- function(sheet_name){
#   read_sheet("https://docs.google.com/spreadsheets/d/1ta71CAGkcLqm-W1UdVRA_JJSddWV2TsrRZsCnQlmOis/edit?usp=sharing",
#              sheet = sheet_name, col_types = c("c")) %>%
#     write_csv(here::here(str_c("data-raw/", sheet_name, ".csv")))
# }
#
# walk(c("cv_entries", "publications"), store_sheet_in_csv)

# create selected CSVs
cv_entries <- read_csv("data-raw/cv_entries.csv") |>
  mutate(year = year(date)) %>%
  mutate(year_end = case_when(
    date_end == "present" ~ date_end,
    !is.na(date_end) ~ str_sub(date_end, 1, 4),
    is.na(date_end) ~ date_end
  )) %>%
  mutate(year = ifelse((is.na(year_end) | year == year_end),
                       year,
                       str_c(year, " --- ", year_end))) |>
  select(-c(short_cv, order, academic, professional_2_page, brief_no_pubs, humanities, humanities_description)) |>
  relocate(type, year, date, year_end, date_end) |>
  relocate(carlsberg, exclude, .after = last_col())

publications <- read_csv("data-raw/publications.csv") |>
  select(-c(exclude, tldr, sigchi_description, sigchi_award_description, project, doctoral_dissertation, short_title, prof_venue, blog, full_talk, full_talk_embed, teaser_video, teaser_video_embed, short_cv, featured, image, professional_2_page, ebook, pdf, bibtex, abstract)) |>
  mutate(year = year(date),
         venue_abbrev = if_else(is.na(venue_abbrev), "", str_c(venue_abbrev, ": "))) |>  # make the abbrevation an empty string if NA; add a colon and a space after if it if there is one
  relocate(type, authors, year, date)

# create an excel workbook where the CSVs are sheets
options("openxlsx.dateFormat" = "yyyy/mm/dd")
list("cv_entries" = cv_entries, "publications" = publications) |>
  write.xlsx(file = "data-raw/cv_data.xlsx", headerStyle = createStyle(textDecoration = "Bold"))

# place the excel file in the templates
template_skeletons <- str_c(list.dirs(path = "inst/rmarkdown/templates", recursive = FALSE), "/skeleton/")

template_skeletons |>
  walk(~ file.copy(from = "data-raw/cv_data.xlsx", to = .x, overwrite = TRUE))

#usethis::use_data(cv_entries, publications, overwrite = TRUE)
