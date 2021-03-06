library(tidyverse)
NYCTrash <- readr::read_csv(
  "NYC_Monthly_Trash.csv"
) %>%
  janitor::clean_names()

NYCTrash <- NYCTrash %>%
  mutate(year = str_extract(NYCTrash$month, "^.{4}"),
         mon = str_extract(NYCTrash$month, "[^/]+$")) %>%
  select(-c(1)) %>%
  rename(month = mon) %>%
  relocate("year", "month") %>%
  rename(
    community_district = communitydistrict,
    refuse_tons_collected = refusetonscollected,
    paper_tons_collected = papertonscollected,
    mpg_tons_collected = mgptonscollected,
    organic_tons_collected = resorganicstons,
    school_organics = schoolorganictons,
    leaves_organics = leavesorganictons,
    xmas_tress = xmastreetons
  )
usethis::use_data(NYCTrash, overwrite = TRUE)
