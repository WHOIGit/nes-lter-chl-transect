# quick script to join with quality_flag from chl transect data frame
# in the future the API will output the quality_flag column
# but for now we put a csv file into the repo created from the Xls sheet in the RDS 'raw' to API
# Stace Beaulieu 19 April 2021

library(tidyverse)

# read in the data frame
# here I am using the data frame that includes nearest station distance
chl_df <- read_csv('nes-lter-chl-transect_dis.csv')

# read in the csv file with quality_flag
# note there are more cruises because ar31, ar34, and ar39
qualities <- read_csv('NESLTERchl_20210409_RDS_quality_flag.csv')

# left join to retain the rows in the chl data frame
chl_qual <- left_join(chl_df, qualities, by = c('cruise','cast','niskin','filter_size','replicate'))

# check that there are no NAs in quality_flag for method_contributor Sosik or Rynearson ie no missing joins
missing_qual <- chl_qual %>%
  filter(method_contributor == "method_Sosik" | method_contributor == "method_Rynearson") %>%
  filter(is.na(quality_flag))
# there is only one missing quality flag, and it actually is missing in the original sheet

# check that there are no values in quality_flag for method_contributor Menden-Deuer ie incorrect join
incorrect_qual <- chl_qual %>%
  filter(method_contributor == "method_Menden-Deuer") %>%
  filter(!is.na(quality_flag))

# I think we can keep the quality flag in the final product but consider using IODE flag
# if we keep quality flag in final product then insert a good quality flag for Menden-Deuer

# maybe add quick check that station in csv qual matches calculated nearest station

# exclude station from csv qual
chl_qual <- select(chl_qual, -station)

