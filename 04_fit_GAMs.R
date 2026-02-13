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
plot(airquality$Temp, airquality$Ozone)
plot(airquality$doy, airquality$Ozone)

# Fit a model where temperature predicts ozone
m1 <- gam(Ozone ~ s(Temp, bs = "cr", k = 20), data = airquality,
          method = "REML")

# Start with model summary
summary(m1)

# See the coefficients
coef(m1)

# Check k
k.check(m1)

# Plot
plot(airquality$Temp, airquality$Ozone)
pred_gam <- data.frame(Temp = seq(65, 95, length.out = 100))
pred_gam$Ozone <- predict(m1, newdata = pred_gam)
lines(pred_gam$Temp, pred_gam$Ozone, col = "blue", lwd = 2)

# Use gratia to plot
draw(m1)

# Plot with confidence interval
plot(airquality$Temp, airquality$Ozone)
pred_gam <- data.frame(Temp = seq(55, 95, length.out = 100))
# Predict with standard errors
pred_gam_obj <- predict(m1, newdata = pred_gam, se.fit = TRUE)
# Add mean and SE to data.frame
pred_gam$Ozone <- pred_gam_obj$fit
pred_gam$se <- pred_gam_obj$se.fit
# Calculate upper and lower CIs
pred_gam$lwr <- pred_gam$Ozone - 1.96*pred_gam$se
pred_gam$upr <- pred_gam$Ozone + 1.96*pred_gam$se

# Plot
lines(pred_gam$Temp, pred_gam$Ozone, col = "blue", lwd = 2)
lines(pred_gam$Temp, pred_gam$lwr, col = "red", lwd = 1, lty = 2)
lines(pred_gam$Temp, pred_gam$upr, col = "red", lwd = 1, lty = 2)

# Find the knots
coef(m1)

# Fit model with Temp and doy
m2 <- gam(Ozone ~ s(Temp, bs = "cr", k = 35) +
            s(doy, bs = "cr", k = 40), 
          data = airquality, method = "REML")
summary(m2)

draw(m2)
k.check(m2)
