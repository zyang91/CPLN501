library(tidyverse)

setwd("C:/Users/zyang/CPLN501/data")
pop <- read.csv("cpln501_module2_central_africa_pop.csv")

plot1 <-ggplot(pop, aes(x = Year, y = Libreville)) +
  geom_point() +
  theme_minimal() +
  labs(title = "Population Trend between 1950 and 2010",
       x = "Year",
       y = "Population") +
  theme(plot.title = element_text(hjust = 0.5))

lbv <- lm(Libreville ~ Year, data = pop)
summary(lbv)

#Access the actual values
lbv$coefficients[1] #intercept
lbv$coefficients[2] #coef for year
lbv$coefficients[1] + lbv$coefficients[2]*2000

predict(lbv)

plot1+ geom_point(aes(y = predict(lbv)), col = "red", pch = 16)

ggplot(pop, aes(x = Year, y = Libreville)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  theme_minimal() +
  labs(title = "Population Trend between 1950 and 2010",
       x = "Year",
       y = "Population") +
  theme(plot.title = element_text(hjust = 0.5))


# Lecture Note #####
# variable in linear trend:
# 1. use more recent data
# 2. use historical data

########Dealing with non-linearity########
# Curve model
# y= a + b1x + b2x^2
# prediction = a + b1*year^2+b2*year
# Variation for curve model
# add more curves by adding higher power terms

#Lag model ######
# y= b0 + b1* pop 5 years + b2*year
#COEF for pop 5 years ago, on average, each additional unit in the 
#population 5years prior to the predicted year corresponds to 0.67 units 
#in the predicted year.
