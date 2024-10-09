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