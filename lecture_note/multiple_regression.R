#Recap ######
#Modal 1 -> linear trend -> pop(predicted)= b+ a*year -> simple regression
#Modal 2 -> curvature trend -> pop(predicted)= b+ a*year + c*year^2 
# -> multiple regression
#Modal 3 -> log -> pop(predicted)= b+ a*log(pop-5 years ago)+ a1*year 
# -> multiple regression

# CROSS-SECTIONAL POPULATION PROJECTION
# Assumptions of OLS regression (ordinary least square)
#1. Homoscedasticity: residuals should be look like a random array of dots 
# evenly dispersed around zero across the predicted values -> residuals vs. fitted values pl
#Good: residuals are evenly distributed around the zero line
#Bad: funnel shaped, Non-linearity

reg1 <- lm(pop_plus10 ~ pop, dat_for_model)
summary(reg1)
abline(reg1, col = "red")

# Good to close to zero, evenly distributed around the zero line
plot(reg1)
hist(resid(reg1))

#2. Normally distribute residuals -> QQ plot (Quantile- Quantile plot)
# better: points lied on the line
# Bad QQ plots indicate our model systematically over or under predicts
hist(dat_for_model$pop_plus10) 
plot(density(dat_for_model$pop_plus10, na.rm = TRUE)) 
