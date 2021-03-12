# script to read in EXCEL file from OOI Alfresco
# Stace Beaulieu 2021-03-12

library(httr)
library(readxl)

url <- ('https://alfresco.oceanobservatories.org/alfresco/webdav/OOI/Coastal%20Pioneer%20Array/Cruise%20Data/Pioneer-09_AR24_2017-10-22/Ship%20Data/Water%20Sampling/Pioneer-09_AR24_Chlorophyll_Sample_Data_2020-03-27_ver_1-00.xlsx')

httr::GET(url, authenticate("guest", "guest"), write_disk(tf <- tempfile(fileext = ".xlsx")))
tf

df <- read_excel(tf, 1L)