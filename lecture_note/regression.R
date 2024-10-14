library(tidyverse)

hr_study <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)
grade <- c(60,70,80,93,94,100,98,95,99,100)
df <- data.frame(hr_study, grade)

ggplot(df, aes(x = hr_study, y = grade)) +
  geom_point() +
  theme_minimal() +
  labs(title = "Relationship between hours of study and grade",
       x = "Hours of study",
       y = "Grade") +
  theme(plot.title = element_text(hjust = 0.5))

# Fit a linear model
lm_fit <- lm(grade ~ hr_study, data = df)
summary(lm_fit)
ggplot(df, aes(x = hr_study, y = grade)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  theme_minimal() +
  labs(title = "Relationship between hours of study and grade",
       x = "Hours of study",
       y = "Grade") +
  theme(plot.title = element_text(hjust = 0.5))

df$new_grade <-c(65, 70, 50, 65, 90, 85, 70, 90, 100, 85)
ggplot(df, aes(x = hr_study, y = new_grade)) +
  geom_point() +
  theme_minimal() +
  labs(title = "Relationship between hours of study and grade",
       x = "Hours of study",
       y = "Grade") +
  theme(plot.title = element_text(hjust = 0.5))
lm_fit1 <- lm(new_grade ~ hr_study, data = df)
summary(lm_fit1)

ggplot(df, aes(x = hr_study, y = new_grade)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  theme_minimal() +
  labs(title = "Relationship between hours of study and grade",
       x = "Hours of study",
       y = "Grade") +
  theme(plot.title = element_text(hjust = 0.5))




# Lecture notes
# Regression is a way to model the relationship between two variable (independent and dependent).
# The model allow us to predict the value of one variable (independent) based 
# on the value of another variable (dependent).

# Simple regression
# One independent variable to predict the dependent variable
# multiple regression
# More than one independent variable to predict the dependent variable

# Question answered
# Examine relationship between dependent and independent variable
#   - The direction of the relationship
#   - The magnitude of the relationship (slope)
#   - linear or non-linear relationship (Linerity)
# Make predictions

# Slope: How much the dependent variable changes 
#        when the independent variable changes by one unit
#        What the line looks like

# Intercept: The value of the dependent variable 
#            when the independent variable is zero
#            Where the line meets x-axis - Where the line is

# Residuals: The difference between the observed value and the predicted value
#            The vertical distance between the observed value and the line

# Ordinary least squares (OLS): 
# The method used to find the line that minimizes the sum of squared residuals
# Y= ax+b
# multiple regression
# ^Y= a1x1 + a2x2 + a3x3 + b
# a1, a2, a3 are the coefficients
# x1, x2, x3 are the independent variables
# Y= b0 + b1x1 + b2x2 + b3x3+ residuals (e)
# Find the line (model) that results in the smallest 
# difference from the observed value to the predicted value
# Find the line that yields the smallest sum of squared residuals

# R squared: measures how much of the variability in the dependent variable
#            can be explained by the model. 
#            The closer to 1, the more variability the model explains the better
#            fits 
# e.g. r^2 =0.8365,- the model explains 83.65% of the variability in the dependent variable
# only use adjusted R squared rather than multiple R squared
#standard error: The average distance between the observed value and the predicted value
#                The average distance between the observed value and the line
#                measure the potential variation of coefficients
# If sd errors are large, the coefficients could be within a wide range of possible values
# We are less certain relationship between dependent and independent variable

# If sd error is big enough to indicate the possible value for coefficients include
# 0, we are uncertain about the relationship.

# t-value: The coefficient divided by the standard error, tells us if sd errors is big enough
#          to indicate the possible value for coefficients include 0

# confidence level: The probability that the coefficient is within a certain range
# t= 1.96, 95% confidence level
# t= 2.58, 99% confidence level
# t= 1.67, 90% confidence level
# If absolute value of t = 1.96, we are 95% confident that the range of our coefficient 
# that not include 0
# If absolute value of t >1.96, we are at least 95% confident that the range of our coefficient
# that not include 0. It suggests that the association between the independent and dependent
# variable is statistically significant

# pr - probabilities
# translate the t-value into a probability of the coefficient crossing zero
# If Pr is less than 0.05, then there is less than less than a 5% chance that the coefficient
# crosses zero. - significant association.

# F-statistic: Whether the model predicts the model predicts significant better than base model(average)
# if p-value associated with F-statistic is less than 0.05, the model predicts the significantly 
# better than mean.
