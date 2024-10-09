#POPULATION PROJECTION USING REGRESSION
#CPLN5010 QUANTITATIVE PLANNING ANALYSIS METHODS
#FALL 2024
library(tidyverse)
rm(list=ls())

setwd("C:/Users/zyang/CPLN501/data")
pop <- read.csv("cpln501_module2_central_africa_pop.csv")

#Data inspection
#In this example, we will use pop$Libreville as the dependent variable
#against independent (explanatory) variable(s).

#scatterplot
plot(pop$Year, pop$Libreville,
     main = "Population Trend between 1950 and 2010",
     xlab = "Year", ylab = "Population", 
     col = "red", pch = 16)

#Model 1####
lbv <- lm(Libreville ~ Year, data = pop)
summary(lbv)
options(scipen=999) #scientific notation off
summary(lbv)
#How to interpret?
#coefficients
#significance
#model fit

abline(lbv)

#equation for line
#get estimated pop for year 2000
#estimation = -21847.91 + 11.17 * 2000
#using actual rather than rounded value of coefficients: more precise 
#extract actual number using subscript
lbv$coefficients[1] #intercept
lbv$coefficients[2] #coef for year
lbv$coefficients[1] + lbv$coefficients[2]*2000

#use predict function to get estimated pop for all years in data
predict(lbv)
points(pop$Year, predict(lbv), 
       col = "black", pch = 16)

#we can also use the predict function to project out 
#predict function allows us to feed new data into the command
futurepop <- data.frame(seq(from = 2040, to = 2100, by = 10)) #data frame from 2040 to 2100 in 10 yr increment
colnames(futurepop) <- "Year" #make sure the variable in the new dataset has same name as indep. var. in model
futurepop$pred_pop <- predict(lbv, newdata = futurepop)

#does our model do a good job?
plot(pop$Year, pop$Libreville)
abline(lbv)
#are we likely to over or underestimate 2020 pop based on current model (trend line)?

#Model 1 variation 1####
#use more recent data####
plot(pop$Year, pop$Libreville)

lbv_1970 <- lm(Libreville ~ Year, data = pop[pop$Year >= 1970,])
summary(lbv_1970)

#does this model yield better prediction to existing data?
par(mfrow=c(1,2)) #splitting canvas
plot(pop$Year, pop$Libreville, main = "Recent data")
abline(lbv_1970)
plot(pop$Year, pop$Libreville, main = "All data")
abline(lbv)

#compare residual sum of squared between recent data and all data
#sum of (actual population - predicted population using lbv_1970 model)^2
sum((pop$Libreville - predict(lbv_1970, newdata = pop))^2)

#sum of (actual population - predicted population using lbv model)^2
sum((pop$Libreville - predict(lbv, newdata = pop))^2)

#So, the model using 1970 and later data does not fit the whole dataset as well, but...
#does it fit more recent data (>= 1970) better?
#1970 model
sum((pop$Libreville[pop$Year >= 1970] - predict(lbv_1970, newdata = pop[pop$Year >= 1970,]))^2)
#full model
sum((pop$Libreville[pop$Year >= 1970] - predict(lbv, newdata = pop[pop$Year >= 1970,]))^2)


#use historical data before 1995####
lbv_back <- lm(Libreville ~ Year, data = pop[pop$Year < 1995,])
summary(lbv_back)

par(mfrow=c(1,2)) #splitting canvas
plot(pop$Year, pop$Libreville, main = "Historical data")
abline(lbv_back)
plot(pop$Year, pop$Libreville, main = "All data")
abline(lbv)

#plot all three models in one plot
par(mfrow=c(1,1))
plot(pop$Year, pop$Libreville)

abline(lbv_1970, col = "red")
abline(lbv)
abline(lbv_back, col = "blue")
legend(1950, 600, 
       legend=c("all data", "<1995", ">=1970"),
       col=c("black", "blue", "red"), lty = 1)

########Dealing with non-linearity########
plot(pop$Year, pop$Libreville)

#add a quadratic term
lbv2 <- lm(Libreville ~ Year + I(Year^2), data = pop)
#what does the I()
#https://stackoverflow.com/questions/24192428/what-does-the-capital-letter-i-in-r-linear-regression-formula-mean
options(scipen=999) 
summary(lbv2)

points(pop$Year, predict(lbv2), 
       col = "red", pch = 16)
lines(pop$Year, predict(lbv2), col = "red") #smooth line through points

#predicting 2010 population
lbv2$coefficients[1] + lbv2$coefficients[2]*2010 + lbv2$coefficients[3]*(2010^2)

#how to predict 2020 and 2030?
futurepop <- data.frame(c(2020, 2030)) #data frame for 2020 and 2030
colnames(futurepop) <- "Year" #make sure the variable in the new dataset has same name as indep. var. in model
predict(lbv2, newdata = futurepop)

#calculate square residual to compare with other model outcomes

#time lag####
#associating population in previous year with current year (1950 with 1955)
#use population of past year as predictor for population today
library(tidyverse)
pop <- pop %>% 
  mutate(Libreville_pop_5_years_ago = lag(Libreville, 1)) %>% #shifting whole column down one row (i.e., creating lag)
  select(Year, Libreville, Libreville_pop_5_years_ago)

lbv3 <- lm(Libreville ~ Libreville_pop_5_years_ago + Year, data = pop)
summary(lbv3)

plot(pop$Year, pop$Libreville)
points(pop$Year[pop$Year >= 1955], predict(lbv3), 
       col = "red", pch = 16)
lines(pop$Year[pop$Year >= 1955], predict(lbv3), col = "red")

#be careful about predicting. do not plug in year directly.
#how to predict 2020 population?
#pop2020 = b0 + b1*pop2015 + b2*year2020
#need to predict 2015 pop first 
#pop2015 = b0 + b1*pop2010 + b2*year2015
lbv3$coefficients[1] + lbv3$coefficients[2]*631 + lbv3$coefficients[3]*2015
#predict function won't help