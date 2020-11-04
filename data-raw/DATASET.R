library(tidyverse)
NYC_Trash <- readr::read_csv(
  "NYC_Monthly_Trash.csv"
) %>%
  janitor::clean_names()

NYC_Trash <- NYC_Trash %>%
  mutate(year = str_extract(NYC_Trash$month, "^.{4}"),
         mon = str_extract(NYC_Trash$month, "[^/]+$")) %>%
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
usethis::use_data(NYC_Trash, overwrite = TRUE)
