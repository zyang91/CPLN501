#REGRESSION BASICS
#CPLN5010 QUANTITATIVE PLANNING ANALYSIS METHODS
#FALL 2024

rm(list = ls())
#Grades v. hours of study example####
#Creating data frame
grades <- c(60, 65, 55, 70, 85, 80, 75, 85, 95, 90)
hours <- c(1, 2, 2, 4, 5, 6, 6, 7, 9, 10)
dat <- cbind.data.frame(grades, hours)
View(dat)

#Replicating plot I drew in class
plot(dat$hours, dat$grades, ylim = c(50, 100))

#syntax for regression models: 
#lm(dependent variable ~ independent variable 1 + independent variable 2 +..., data = )
#storing the model in an object called mod.1
mod.1 <- lm(grades ~ hours, data = dat)
#to see results of model, use summary
summary(mod.1)

#important items to look at in regression results
#intercept, coefficients, stars, R-squared

#plot regression line (model) on plot
abline(lm(grades ~ hours, data = dat))

#creating a new variable called new_grades
dat$new_grades <- c(65, 70, 50, 65, 90, 85, 70, 90, 100, 85)
View(dat)
points(dat$hours, dat$new_grades, col = "red", pch = 16)

#plot regression line for new grades
abline(lm(dat$new_grades ~ dat$hours), col = "red")

#run model with new grades being dependent variable
mod.2 <- lm(new_grades ~ hours, data = dat)
summary(mod.2)
#note the reduction in R squared

#generate some random data
#set seed ensures numbers generated are reproducible
set.seed(1)
dat$random <- runif(10, min = 20, max = 60)

#run a multiple regression
mod.3 <- lm(grades ~ hours + random, data = dat)
summary(mod.3)

#compare R squared with mod.1
summary(mod.1)

