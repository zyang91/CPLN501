#CROSS-SECTIONAL POPULATION PROJECTION
#CPLN5010 QUANTITATIVE PLANNING ANALYSIS METHODS
#FALL 2024

rm(list=ls())
load("cpln501_module2_census_tract.rda")
#it is a good habit to give your variables descriptive names
#pop = 2000 population; pop_plus10 = 2010 population
#indep. vars in dat_for_model are for 2000

#DATA INSPECTION####
head(dat_for_model)
summary(dat_for_model)

#BUILD MODEL####
#Let's start with a simple regression predicting 2010 census tract population.
#Based on what we discussed before, what would likely be a robust predictor? 
plot(dat_for_model$pop, dat_for_model$pop_plus10)

reg1 <- lm(pop_plus10 ~ pop, dat_for_model)
summary(reg1)
abline(reg1, col = "red")
#interpret the coefficient
#it looks from our plot like we're under-predicting some of the more populous census tracts

#let's check the residuals to see how well our model does
plot(reg1)
hist(resid(reg1)) #resid() gives us the residual for each predicted value

##let's look a bit more closely at the variable we are trying to predict
hist(dat_for_model$pop_plus10) #frequency
plot(density(dat_for_model$pop_plus10, na.rm = TRUE)) #does it look normal (like a bell curve)?

plot(dat_for_model$pop, dat_for_model$pop_plus10)
#let's try to deal with it with a quadratic term
reg2 <- lm(pop_plus10 ~ pop + I(pop^2), dat_for_model)
summary(reg2)
plot(reg2)

#can we tell from plot which prediction is better?
plot(dat_for_model$pop, dat_for_model$pop_plus10)
points(dat_for_model$pop[is.na(dat_for_model$pop_plus10) == FALSE & is.na(dat_for_model$pop) == FALSE ], 
       predict(reg2), col = "blue", pch = 16)

points(dat_for_model$pop[is.na(dat_for_model$pop_plus10) == FALSE & is.na(dat_for_model$pop) == FALSE ], 
       predict(reg1), col = "red", pch = 16)

#try other variables
plot(dat_for_model$pop_25_plus, dat_for_model$pop_plus10)

#population over 25 might be a good choice
reg3 <- lm(pop_plus10 ~ pop_25_plus, data = dat_for_model)
summary(reg3)

#but...
reg4 <- lm(pop_plus10 ~ pop_25_plus + pop, data = dat_for_model)
summary(reg4)

#what are some other variables we might think influence population in a Census tract in 10 years
#how about income, if we think wealthy neighborhoods are growing or emptying faster
reg5 <- lm(pop_plus10 ~ pop + I(pop^2)+ median_hh_income, data = dat_for_model)
summary(reg5)
plot(reg5)

#let's try looking at race
#which of these do you prefer?
reg6 <-  lm(pop_plus10 ~ pop + pop_black, data = dat_for_model)
summary(reg6)

reg7 <-  lm(pop_plus10 ~ pop + pop_black + pop_asian, data = dat_for_model)
summary(reg7)

#How do you decide which variables to add and which variables are better?
# 1)Theory
#Plots are a great place to start if you don't have a good theory
plot(dat_for_model$edu_collegeplus, dat_for_model$pop_plus10)

# 2)Statistical significance and fit
#Focus on adjusted R-squared and significance of individual variables

# 3)Residual (error) terms and plots
#Are we violating assumptions?

#How well do we predict Philly's 2010 population
sum(dat_for_model$pop_plus10, na.rm=TRUE) #actual 2010 population
sum(predict(reg5)) #population projection seems low
sum(predict(reg5, newdata = dat_for_model), na.rm=TRUE) #predicted 2010 population
#na.rm=TRUE: the sum function won't run if there are NAs in data

#Now, how do we make predictions for 2020?
#Sum population prediction
sum(predict(reg5, newdata= dat_for_pred), na.rm=TRUE) 

#creating a new column of predicted 2020 population for each tract
dat_for_pred$pop2020_est <- predict(reg5, newdata= dat_for_pred)


install.packages("stargazer")
library(stargazer)
stargazer(reg4, reg5, type = "text",
          star.cutoffs = c(0.05, 0.01, 0.001))

