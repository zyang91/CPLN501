#TIPS FOR ASSIGNMENT 2
#CPLN5010 QUANTITATIVE PLANNING ANALYSIS METHODS
#FALL 2024

library(tidyverse)
#CREATING DATA####
#enter Philly's population between 1950 and 2010
#into the commands below
year <- c(1950, 1960, 1970, 1980, 1990, 2000, 2010)
population <- c(2071605,2002512,1948609,1688210,1585577,1517550,1526006)  
dat <- cbind.data.frame(year, population)

#the assignment asks you to estimate three regression models
#1. linear
#2. non-linear
#3. lag
#and use each model to project population

#LINEAR TREND####
#TASK: first, let's estimate a linear trend####
mod.1 <- lm(population ~ year, data = dat)
summary(mod.1)

dat$predicted_population1 <- predict(mod.1)
#TASK: to project population in 2020 and 2030, we can feed a new data set into the predict function
futurepop <- data.frame(year = c(2020, 2030)) #creating new data frame

#TASK: make sure the variable in the new dataset has same name as indep. var. in model

#TASK: create a new variable in futurepop, then store the predicted population in the variable

#TASK: visualize the regression line
ggplot(dat, aes(x = year, y = population)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Linear Trend Philadelphia Population (2010-2010)",
       x = "Year",
       y = "Population")

#add regression line
#is this a good prediction for 2020? why or why not?

#NON-LINEAR TREND####
#TASK: next, let's try a model with a quadratic term
mod.2 <- lm(population ~ year+I(year^2) , data =dat)
summary(mod.2)


# Get predictions from the model
dat$predicted_population1 <- predict(mod.2)

# Plot the original data and the fitted curve
ggplot(dat, aes(x = year, y = population)) +
  geom_point() +  # Original data points
  geom_line(aes(y = predicted_population1), color = "green") +  # Fitted line
  labs(title = "Non-linear Trend of Philadelphia Population (2010-2010)",
       x = "Year",
       y = "Population")


#TASK: add another column in futurepop and store predicted population in the column

#LAG MODEL####
#TASK: finally, let's try a model with lag
library(tidyverse)
#first, let's create a population with 10 year lag (i.e., shifting one row down)
dat <- dat %>% mutate(pop_lag = lag(population, 1))

#TASK: build the model with year and lag
mod.3 <- lm(population ~ year + pop_lag, data = dat)
summary(mod.3)

dat$predicted_population <- NA  # Initialize the predicted column with NA values
dat$predicted_population[!is.na(dat$year) & !is.na(dat$pop_lag)] <- predict(mod.3)

# Plot the actual data and the fitted line from mod.3
ggplot(dat, aes(x = year, y = population)) +
  geom_point() +  # Original data points
  geom_line(aes(y = predicted_population), color = "red") +  # Fitted line
  labs(title = "Lag Model of Philadelphia Population (2010-2010)",
       x = "Year",
       y = "Population")

  
  
ggplot(dat, aes(x = year, y = population)) +
  geom_point() +  # Original data points
  geom_smooth(method = "lm", se = FALSE, color="blue") +
  geom_line(aes(y = predicted_population1), color = "green") +  # Fitted line
  geom_line(aes(y = predicted_population), color = "red") +  # Fitted line
  labs(title = "Comparison of Linear, Non-linear, and Lag Models of Philadelphia Population (2010-2010)",
       x = "Year",
       y = "Population")+


#TASK: project population 2020

#TASK: project population 2030

#based on your judgment, which model will likely predict the best?
#TASK: plot all three trends on same plot
plot(, ,
     main = "", #give plot a title
     xlab = "", ylab = "", #add labels for x and y axes
     col = "black", pch = 16)
lines()
lines()
lines()