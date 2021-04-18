# quick script to populate nearest station when less than 1 km away
# Stace Beaulieu 18 April 2021
library(tidyverse)
library(geosphere)

chl <- read_csv('nes-lter-chl-transect.csv')
# initialize nearest station and distance columns to NA
chl$nearest_station <- NA_character_
chl$distance <- NA_integer_

# use a standard list of stations L1-L13
# read csv into stations
stations <- read_csv('NES-LTER_standard_stations_201808.csv')

station_matrix <- matrix(data = c(stations$longitude, stations$latitude), nrow = 14, ncol = 2, byrow = FALSE,
             dimnames = NULL)

for (df_row in 1:nrow(chl)) {
  df_lon <- chl$longitude[df_row]
  # add an if else to skip the row if the df longitude is NA
  
  df_lat <- chl$latitude[df_row]
  df_lon_lat <- c(df_lon,df_lat)
  km_from_df <- distHaversine(station_matrix, df_lon_lat, r=6378.137)
  # index the minimum distance
  index <- which.min(km_from_df)
  # use that index to pull the station name and its distance
  nearest_station <- stations[index,'station']
  distance <- km_from_df[index]
  
  # If distance less than 1 km, use base R to add to respective columns in the full data table within the for loop
  # this might be working but is giving an error I think bc null values in some rows can't run the distance
  if (distance < 1) {
  # if (!is.null(distance) & distance < 1) { # this did not correct the error
    chl$nearest_station[df_row] <- nearest_station
    chl$distance[df_row] <- distance
  } 
}

