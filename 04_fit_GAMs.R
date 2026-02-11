# Fitting GAMs using `mgcv`

# We will fill this in during the workshop and then update this script.

# Load packages ----
library(dplyr)
library(mgcv)
library(lubridate)
library(gratia)

# Load data ----
# Simulated data

# Real data (base R dataset)
# Data are from New York City in 1973
data("airquality")

airquality <- airquality %>% 
  mutate(date = ymd(paste("1973", Month, Day, sep = "-")),
         doy = yday(date))

# Fit GAM to simulated data ----

# Fit GAM to real data ----
# Ozone depends on day of year and temperature
