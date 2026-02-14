# Fitting SSFs using `amt`

# We will fill this in during the workshop and then update this script.

# Load packages ----
library(amt)
library(terra)
library(dplyr)
library(lubridate)
library(ggplot2)

# Load data ----
# Load the GPS data
gps <- read.csv("data/coyote_cougar.csv") %>% 
  mutate(t_ = ymd_hms(t_)) %>% 
  # Subset to the cougar F53
  filter(id == "F53")

# Load the habitat layers
hab <- rast("data/coyote_cougar_habitat.tif")
names(hab) <- c("elev", "tree", "biomass", "dist_to_road")

plot(hab)

# Prepare data ----
dat <- gps %>% 
  make_track(x_, y_, t_, all_cols = TRUE, crs = 32612) %>% 
  track_resample(rate = hours(4), tolerance = minutes(30)) %>% 
  steps_by_burst() %>% 
  random_steps(n_control = 30) %>% 
  extract_covariates(hab)

# Fit SSF ----
m <- fit_ssf(dat, 
             # Response variable
             case_ ~ 
               # Habitat variables
               elev + I(elev^2) +
               tree +
               biomass +
               log(dist_to_road) +
               # Movement variables
               log(sl_) + sl_ +
               cos(ta_) +
               # Specify the strata
               strata(step_id_),
             model = TRUE
             )

summary(m)

# Figures ----
# Scenario
x1 <- data.frame(elev = 2500,
                 tree = mean(dat$tree),
                 biomass = mean(dat$biomass),
                 dist_to_road = mean(dat$dist_to_road),
                 sl_ = 1000,
                 ta_ = 0)

x2 <- data.frame(elev = 2200,
                 tree = mean(dat$tree),
                 biomass = mean(dat$biomass),
                 dist_to_road = mean(dat$dist_to_road),
                 sl_ = 1000,
                 ta_ = 0)

lr <- log_rss(m, x1, x2, ci = "se")

# The 'lr' object has a bunch of information inside it
# We probably care about the "df" element
lr$df

# Get RSS
exp(lr$df$log_rss)

# Plot selection for elevation
x1 <- data.frame(elev = seq(from = 2000, to = 3000,
                            length.out = 100),
                 tree = mean(dat$tree),
                 biomass = mean(dat$biomass),
                 dist_to_road = mean(dat$dist_to_road),
                 sl_ = 1000,
                 ta_ = 0)

x2 <- data.frame(elev = 2500,
                 tree = mean(dat$tree),
                 biomass = mean(dat$biomass),
                 dist_to_road = mean(dat$dist_to_road),
                 sl_ = 1000,
                 ta_ = 0)

lr <- log_rss(m, x1, x2, ci = "se")

lr$df %>% 
  mutate(rss = exp(log_rss),
         rss_lwr = exp(lwr),
         rss_upr = exp(upr)) %>% 
  ggplot(aes(x = elev_x1, y = rss, 
             ymin = rss_lwr, ymax = rss_upr)) +
  geom_ribbon(linetype = "dashed", fill = "gray90",
              color = "black") +
  geom_line(linewidth = 1) +
  geom_hline(yintercept = 1, color = "red", linetype = "dashed") +
  xlab("Elevation at x1") +
  ylab("Relative Selection Strength") +
  theme_bw()

# Make a map
x1 <- as.data.frame(hab, xy = TRUE) %>% 
  mutate(sl_ = x2$sl_,
         ta_ = x2$ta_)
head(x1)

# Use our x2 from above

# Calculate log-RSS for every pixel on the landscape
lr <- log_rss(m, x1, x2)

# Map
ggplot(lr$df, aes(x = x_x1, y = y_x1, fill = exp(log_rss))) +
  geom_raster() +
  coord_equal() +
  scale_fill_viridis_c()

# Update step length distribution
update_sl_distr(m, beta_log_sl = "log(sl_)")
