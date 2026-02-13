# Simulating data under various regression models

# We will fill this in during the workshop and then update this script.

# Load packages ----

# Ordinary Linear Regression ----
# Set the random seed
set.seed(20260211)

# Generate an x variable in a data.frame
lm_data <- data.frame(x = runif(n = 200, min = -1, max = 1))

# Pick some values for slope, intercept, and SD
b0 <- -4
b1 <- 2.5
sigma <- 1

# Calculate mu
lm_data$mu <- b0 + b1 * lm_data$x

# Generate the random variable
lm_data$y <- rnorm(n = nrow(lm_data), mean = lm_data$mu, sd = sigma)

# Plot
plot(lm_data$x, lm_data$y)

# Fit a model
lm_fit <- lm(y ~ x, data = lm_data)

# Summary
summary(lm_fit)

# Coefficients
coef(lm_fit)

# Confidence intervals
confint(lm_fit)

# Histogram of response variable
hist(lm_data$y)

# Plot the data and the line
plot(lm_data$x, lm_data$y)
abline(lm_fit, col = "blue", lwd = 2)

# Generalized Linear Models ----
# Set seed
set.seed(54321)

# Choose beta_0 and beta_1
beta0 <- 2
beta1 <- -3

# Create a data.frame to hold the data
glm_data <- data.frame(x = runif(n = 300, min = -1, max = 1))

# Calculate log(lambda)
glm_data$log_lambda <- beta0 + beta1 * glm_data$x

# Calculate lambda
glm_data$lambda <- exp(glm_data$log_lambda)

# Draw random variable (y)
glm_data$y <- rpois(n = nrow(glm_data), 
                    lambda = glm_data$lambda)

# Plot
plot(glm_data$x, glm_data$y)

# Make a histogram of y
hist(glm_data$y)
# Summary stats
mean(glm_data$y)
var(glm_data$y)

# Fit a model
glm_fit <- glm(y ~ x, data = glm_data, family = poisson())

# Check the summary
summary(glm_fit)

# Grab the coefficients
coef(glm_fit)

# Get the confidence intervals
confint(glm_fit)

# Plot the data and the regression line
plot(glm_data$x, glm_data$y)

# Create a data.frame for prediction
glm_pred <- data.frame(x = seq(from = -1,
                               to = 1,
                               length.out = 100))
# Predict using the fitted model
# Because we used argument 'se.fit = TRUE', this returns a 
# list.
glm_predict_obj <- predict(glm_fit, newdata = glm_pred,
                           type = "link", se.fit = TRUE)

# Copy elements from the list to the data.frame
glm_pred$log_lambda <- glm_predict_obj$fit
glm_pred$se <- glm_predict_obj$se.fit

# Calculate the bounds of a 95% confidence interval
glm_pred$log_lwr <- glm_pred$log_lambda - 1.96*glm_pred$se 
glm_pred$log_upr <- glm_pred$log_lambda + 1.96*glm_pred$se

# Backtransform
glm_pred$lambda <- exp(glm_pred$log_lambda)
glm_pred$lwr <- exp(glm_pred$log_lwr)
glm_pred$upr <- exp(glm_pred$log_upr)

# Add the line
lines(glm_pred$x, glm_pred$lambda, col = "blue", lwd = 2)
lines(glm_pred$x, glm_pred$lwr, col = "blue", lwd = 2, lty = 2)
lines(glm_pred$x, glm_pred$upr, col = "blue", lwd = 2, lty = 2)

# Mixed Models ----

# GAMs ----
