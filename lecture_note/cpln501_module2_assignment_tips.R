#TIPS FOR ASSIGNMENT 2
#CPLN5010 QUANTITATIVE PLANNING ANALYSIS METHODS
#FALL 2024

rm(list=ls())

#CREATING DATA####
#enter Philly's population between 1950 and 2010
#into the commands below
year <- c()
population <- c()  
dat <- cbind.data.frame(,)

#the assignment asks you to estimate three regression models
#1. linear
#2. non-linear
#3. lag
#and use each model to project population

#LINEAR TREND####
#TASK: first, let's estimate a linear trend####
mod.1 <- lm( ~ , data = )
summary(mod.1)

#TASK: to project population in 2020 and 2030, we can feed a new data set into the predict function
futurepop <- data.frame() #creating new data frame

#TASK: make sure the variable in the new dataset has same name as indep. var. in model

#TASK: create a new variable in futurepop, then store the predicted population in the variable

#TASK: visualize the regression line
plot(, ,
     main = "", #give plot a title
     xlab = "", ylab = "", #add labels for x and y axes
     col = "black", pch = 16)
abline(mod.1)
#is this a good prediction for 2020? why or why not?

#NON-LINEAR TREND####
#TASK: next, let's try a model with a quadratic term
mod.2 <- lm( ~ , data = )
summary(mod.2)

#will this model likely do a good job at predicting 2020 population? 
#TASK: plot the line
plot(, ,
     main = "", #give plot a title
     xlab = "", ylab = "", #add labels for x and y axes
     col = "black", pch = 16)

#TASK: plot the points
points()

#TASK: plot smooth line through points
lines() 

#TASK: add another column in futurepop and store predicted population in the column

#LAG MODEL####
#TASK: finally, let's try a model with lag
library(tidyverse)
#first, let's create a population with 10 year lag (i.e., shifting one row down)
dat <- dat %>% mutate(pop_lag = lag(population, 1))

#TASK: build the model with year and lag
mod.3 <- 
summary()

#TASK: plot the points
plot()
points()

#TASK: plot the line that connects the predicted values
lines(dat$year[dat$year > 1950], predict(mod.3), col = "red") #you need to make sure the subset of data has equal number of observations for indep. adn dep. variables

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