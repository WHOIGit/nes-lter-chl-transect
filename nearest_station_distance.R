# quick script to populate nearest station when less than 1 km away
# Stace Beaulieu 19 April 2021
library(tidyverse)
library(geosphere)

# read in the data frame that has the lat/lons for which you want to determine nearest station distance
chl <- read_csv('nes-lter-chl-transect.csv')
# reads in alternate_sample_id as logi as opposed to chr


# rename data frame and initialize nearest station and distance columns to NA
chl_dis <- chl
chl_dis$nearest_station <- NA_character_
chl_dis$distance <- NA_integer_

# use a standard list of stations L1-L13
# read list csv into stations
stations <- read_csv('NES-LTER_standard_stations_201808.csv')

station_matrix <- matrix(data = c(stations$longitude, stations$latitude), nrow = 14, ncol = 2, byrow = FALSE,
             dimnames = NULL)

# calculate distance per row of the data frame
for (df_row in 1:nrow(chl_dis)) {
  df_lon <- chl_dis$longitude[df_row]
  df_lat <- chl_dis$latitude[df_row]
  # add an if to skip the row if df lon and/or lat is NA
  if (!is.na(df_lon) & !is.na(df_lat)) {
    df_lon_lat <- c(df_lon,df_lat)
    km_from_df <- distHaversine(station_matrix, df_lon_lat, r=6378.137)
    # index the minimum distance
    index <- which.min(km_from_df)
    # use that index to pull the station name and its distance
    nearest_station_list <- stations[index,'station']
    # need to change this from a list to char
    nearest_station <- unname(unlist(nearest_station_list))
    distance <- km_from_df[index]
    # If distance less than 1 km, use base R to add to respective columns in the full data table within the for loop
    if (distance < 1) {
      chl_dis$nearest_station[df_row] <- nearest_station
      chl_dis$distance[df_row] <- distance
    }
  }
}

chl_dis$distance <- round(chl_dis$distance, 2)

# write the file to inspect the output
write.csv(chl_dis, 'nes-lter-chl-transect_dis.csv', row.names=FALSE)
