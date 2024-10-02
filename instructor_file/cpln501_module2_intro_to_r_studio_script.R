#Introduction to R and RStudio
#Intro to basic syntax
#CPLN5010 QUANTITATIVE PLANNING ANALYSIS METHODS
#FALL 2024

# Download software####
# R 
# http://cran.r-project.org
# R Studio
# https://rstudio.com/products/rstudio/download/#download

# BASIC R####
# To start new file/script > File > New File > R Script
# Type and run commands in this window
# To open R file > File > Open File
# To save script > File > Save as

# Pound (#) sign is for comments
# Use # every line for comments that change line
# Can't hash out text block. Bummer!
# Repeated 4 times after comment for section heading for navigation

# Clear workspace####
rm(list=ls()) # clear leftover from last session
?rm()
help(rm)
#or Google
# Ctrl+Enter is a faster way to run your code. Command+Enter on Mac
# If you would like to select a block of code 
# and run them at once,
# hold down Shift and use your arrow keys to select.

# CODING
# R is an object based language- create/manipulate objects
# Object/Variable <- Function/Value
# <- means = 

# Creating new objects
numberA <- 3  # appear in Environment pane
numberA
numberB <- 2
numberA + numberB # operate with objects

sumAandB <- numberA + numberB # store value in object
sumAandB
# an object does not have to be a number
# it could be texts, a table, a statistical model, an image, etc.
Penn <- "University of Pennsylvania"
Penn
Penn <- University of Pennsylvania  # doesn't work if texts are not quoted
# unless "text" is an existing object...
upenn <- Penn
upenn

# Naming convention
U.P. <- "Urban Planning" # full stops are fine
Urban_Planning <- "Urban Planning" # Underscores are fine
number1 <- "Number 1" # Numbers are fine 
1number <- "number 1" # Not okay! Can't start with numbers, which means it cannot be all numeric like 123
# !, -, *, & space are not okay!
# Unexpected symbol

# Creating a simple data frame (table) of Ravens roster
# https://www.baltimoreravens.com/team/players-roster/
# to open link, shift + click 
# create each column and combine them
# names, number, height, weight, college

name <- c("Lamar Jackson", "Tyler Huntley", # wrap texts in quotes 
          "Jaylon Moore", "Brandon Williams", 
          "Justin Tucker") 
# What does c() do?
# Combining several items into one object

# changing line is fine but make sure R knows there is something on the next line
# by ending with a symbol
name
# Functions are case sensitive

number <- c(8, 2, 81, 98, 9)
ht <- c(6.2, 6.1, 5.11, 6.1, 6.1)
wt <- c(212, 196, 191, 336, 183)
col <- c("Louisville", "Utah", "Tenn-Mart", "MSU", "Texas")

# Combine
raven.1 <- data.frame(name, number, ht, wt, col)
raven.1
# or view table using view() or click Data in Environment window
# view in ascending/descending order by clicking arrow on header
# Could use colnames() function to change column names. Google it.
colnames(raven.1) <- c("Player", "Jersey", "Height", "Weight", "College")
# A thousand ways to do everything in r

# Add a column called posn
posn <- c("QB", "QB", "WR", "DT", "K")
raven.2 <- cbind(raven.1, posn) 
raven.2

# Save data frame(s)
# Remember to change direction of the slash sign.
# Have to specify file type (in this case, .csv).
# csv takes up less space, but does not preserve formatting or formulas
write.csv(raven.1, file = "", row.names = FALSE) 

# read in data
# Copy file path (shift + right click on PC)
# On Mac https://apple.stackexchange.com/questions/338898/how-to-copy-path-of-a-file-in-mac-os/338899
NewData <- read.csv("", header=TRUE) # Assign data frame to an object

# store the data frame in a new object called R Data (rda file)
# allows saving multiple data frames and objects in one file
# allows you to import files directly into R without having to recreate them
save(raven.1, raven.2, NewData, 
     file = "")
rm(list = ls())
load("")
# save script because contents in the console will be gone in new session 


# Use R as calculator
8 + (2 - 1) * 5 / (3^2) + sqrt(4) - 8^(1/3) + log(4) - exp(2)

# mathematical operations with vectors of numbers
number <- c(33, 13, 81, 26, 96)
ht <- c(6.2, 6.0, 6.2, 6.0, 6.3)
number * 2
number + ht
log(number)
exp(number)


#Working with data frame####
# File > Open File or use command
rm(list=ls())
setwd("") # Path to the folder on your computer. For PC- change the default \ to /
# Convenient for you and others
# because we set working directory, we do not need to type the whole file path when saving or loading files.
NewData <- read.csv("", header=TRUE)

load("") #import baltimore_census.rda

# Data inspection
# Clicking on data frame in Environment pane shows the table
str(baltimore) # Structure of data.
#data class: number v. character
#can't perform mathematical operations on character or factor
#need to convert to numeric before doing mathematical operations
dim(baltimore) # Dimension of data set, i.e., No. of rows and cols.
length(baltimore) # Shows the no. of cols. 
# We could use the values these functions return
head(baltimore) # a snippet 
head(baltimore,3) # First 3 rows for every column in dat2010.
tail(baltimore,4) # Last 4 rows
names(baltimore) # Shows all the column names.
summary(baltimore) # Shows summary statistics. Can use it on single column.

# $column name gives access to single column.
baltimore$pov_moe  

table(baltimore$fake_region) # Frequency table
table(baltimore$fake_region)/length(baltimore$area) # Proportion
table(baltimore$fake_region, baltimore$pop_quantile) # Cross table of... 
#how many Census tracts belong in each fake region I created

# Basic calculation
sum(baltimore$area)
mean(baltimore$area)
median(baltimore$area)
sd(baltimore$area) # standard deviation
max(baltimore$area) # maximum
min(baltimore$area) # minimum

# subscripting (access certain item by specifying its location like coordinates)
# [row#, column#]
baltimore[1,2] # Calls the value in the first row of the second col.
baltimore[2,1] <- 99999 # change the value in cell [2,1] to 99999

baltimore[2,] # Access 2nd row for all columns
baltimore[,2] # Access values in 2nd column

baltimore[,c(1,2)] # Access only columns 1 and 2
baltimore[,c(1:4)] # Access columns 1 through 4 using :
new.bmore <- baltimore[,c(1:4)] # Creating new data frame with only columns 1 through 4 in baltimore
new.bmore <- baltimore[,-c(3:5)] # Store selected columns (- means deselect) in a new object/data frame

# subsetting data
# selecting rows that meet certain conditions
pop.bmore <- baltimore[baltimore$population > 2000 & baltimore$pop_poverty < 500, ]
pop.bmore <- baltimore[baltimore$pop_poverty == 0, ] # == means is exactly equal to
pop.bmore <- baltimore[baltimore$pop_poverty != 0, ] # != means not equal to
pop.bmore <- baltimore[baltimore$population > 2000 | baltimore$population < 500, ] # | means "or"
# == means is exactly equal to (for selection)
# != means not equal to
# = means equal to (for assigning values)
# & means and
# | means or

# Working with columns
baltimore$Pop_Density <- baltimore$population/baltimore$area # Column calculation

baltimore$newcol <- "this is a new column" # Create a new column with same values


#Categorization and tidyverse####
baltimore$population_cat[baltimore$population >= median(baltimore$population)] <- "high" # Create a new column where... 
# all observations with population greater than or equal to median pop. get renamed to "high.
baltimore$population_cat[baltimore$population < median(baltimore$population)] <- "low"

# recategorizing based on more than one condition
baltimore$region_cat <- ifelse(baltimore$fake_region == "east" | 
                           baltimore$fake_region == "west", "region 1", "region 2")

# We've seen how to do things in base R...
# Now let's use some functions that are not in base R
# These functions are in a package (plug-in) called tidyverse
# install.packages("tidyverse") # Only need to install the package once
library(tidyverse) # In every new session, call the package using library

rm(list=ls())
load("") # Import baltimore_census.rda again

# Tidyverse allows us to string commands together
# Now let's make a new data frame bmore by manipulating the data frame baltimore
# 1. renaming columns
# 2. creating new variables, recategorizing values
# 3. removing variables
# 4. filtering out certain regions

bmore <- baltimore %>% # %>% means piping, or carry previous object to next step
  rename(tract_fips = tract_id, # new name = current name
         total_pop = population) %>% # tidyverse does not require $ when dealing with column names
  mutate(poverty_rate = pop_poverty/total_pop, #creating new variables
         pop_density = total_pop/area,
         region_new = recode(fake_region, # recoding regions to something more descriptive
                             `east` = "Region1", 
                             `west` = "Region2", 
                             `north` = "Region3", 
                             `south` = "Region4"),
         pop_category = cut(total_pop, 
                            breaks=c(0, 2062, 2917, 3862, 6612), # recategorizing population by quartile (run summary)
                            labels=c("Q1","Q2","Q3","Q4"))) %>%
  select(-tract_name, -fake_region) %>% # delete certain columns, alternatively, keep certain columns without the - sign
  filter(region_new == "Region1" | region_new == "Region3") # keep observations in Region 1 OR Region 3 (i.e., subsetting)
# run the code one chunk at a time to see what happens

# Merge two tables based on common key values
join1 <- bmore %>% select(tract_fips, total_pop)
join2 <- bmore %>% select(tract_fips, pop_poverty)
join1and2 <- join1 %>% 
  left_join(., join2, # the . indicates the table from the previous step, i.e., join1
            by = c("tract_fips" = "tract_fips")) #like vlookup

# in this case, we actually did not need to specify the "by" argument,
# since the key fields for the join have the same column name.
# must specify if the fields have different names. 
# may join by several fields
# some times the two tables might not have the same observations in the key field
# take a look at the different types of joins to see which observations are kept
# by each type of join
# https://nyu-cdsc.github.io/learningr/assets/data-transformation.pdf

# Aggregate/summarize by category (i.e., average age by gender)
agg <- baltimore %>% 
  group_by(fake_region) %>% # could be multiple fields
  summarise(ave_pop = mean(population), # average population by region
            number_tracts = n(), # number of observations in each region
            sum_poverty = sum(pop_poverty)) #total population in poverty by region

#Data visualization####

rm(list=ls())
load("") # Import census_tracts.Rda

# Base R Plot####
#Histogram
hist(dat2010$pop) # Simple bar chart shows distribution

# Add some labels and color. col can be HEX code (e.g. #FFA500).
# breaks specifies number of bars.
hist(dat2010$pop,
     main="2010 Population", xlab="Population 2010", 
     ylab="Frequency", col="#FFA500", breaks = 20) 

#set canvas layout
par(mfrow=c(1,2)) # (rows, columns)

# Density curve
plot(density(dat2010$pop, na.rm = TRUE),
     main="2010 Population", xlab="Population 2010", 
     ylab="Density",col="blue")

hist(dat2010$pop[dat2010$percent_poverty > 0.3]) # Plot a subset of data


par(mfrow=c(1,1))

# Two boxplots side by side; 
boxplot(dat2010$pop, dat2000$pop, 
        names = c("pop 2010","pop 2000"), 
        main="Pop. Comparison", 
        col = c("blue", "orange")) 

# Scatter plot
# pop_plus10 in dat2000 is pop 2010.
plot(dat2000$pop, dat2000$pop_plus10) #some large tracts in 2000 do not have population in 2010 due to boundaries re-draw
plot(dat2000$pop, dat2000$pop_plus10, 
     xlim = c(0, 8000), # xlim contains min. and max. of x axis
     ylim = c(0, 10000), # y axis limits
     pch = 3, # pch specifies symbol (25 types). You may also define your own symbol using ""
     cex = .5) # Size of symbols

abline(lm(dat2000$pop_plus10 ~ dat2000$pop)) # Add a trend line y axis ~ x axis

# ggplot####
# ggplot is part of tidyverse

# Think of ggplot as a pizza.
ggplot(dat2010, aes(x=pop)) + # This is the crust. Define variables in the aes function.
  # Add toppings, i.e., various layers on your crust.
  geom_histogram(col="black", #line color
                          fill="#225566", #fill of bars
                          alpha = .5, #transparency
                 binwidth = 200) + #change bin, or bar, width
  labs(x="population", y="counts") + # This changes labels for x- and y- axis
  ggtitle("Population 2010") # This changes the title
# When specifying colors, you may use the name or 
# the Hex Color Code such as "#FFFFFF".
# Miranda and Ziyi showed us some websites you can use to get HEX codes for colors
# Google is your friend

# compatibility with piping %>%
dat2010 %>% mutate(perc.white = pop_white_nonhispanic/pop,
                   majority = cut(perc.white,
                                  breaks = c(0, 0.5, 1),
                                  labels = c("nonwhite", "white"))) %>% 
  filter(majority == "white") %>%  # until here the code splits the data by perc. white and takes subset of majority white tracts
  ggplot(aes(x=pop)) +
  geom_histogram(col="black", fill="white",alpha = .5, binwidth = 200) +  
  labs(x="population", y="counts") + 
  ggtitle("Population 2010")

# Scatter plot using ggplot
dat2000 %>% 
  mutate(perc.white = pop_white_nonhispanic/pop,
         majority = cut(perc.white,
                        breaks = c(0, 0.5, 1),
                        labels = c("nonwhite", "white"))) %>%
  drop_na(majority) %>%
  ggplot(., aes(x = pop, y = pop_plus10, color = majority)) + #color by category
  geom_point(size = 2) +
  scale_color_manual(values=c("#999999", "#E69F00")) +
  xlim(0, 8000) +
  labs(x="pop 2000", y="pop 2010") + # Add axis names
  geom_smooth(method = "lm", color = "red", se=FALSE) # Add trend line
#set se to F to delete standard error (shaded gray along trend line)
#to save plots, go to Export in graphic window > Save as Image

# Boxplot using ggplot
dat2010 %>% mutate(perc.white = pop_white_nonhispanic/pop,
                   majority = cut(perc.white,
                                  breaks = c(0, 0.5, 1),
                                  labels = c("nonwhite", "white"))) %>%
  drop_na(majority) %>%
  ggplot(., aes(x=majority, y=median_hh_income, 
                fill = majority)) + #different color for each category.
  geom_boxplot(alpha = 0.7) + 
  labs(x="Race", y="Median HH Income") + 
  scale_fill_manual(values=c("#336699", "#666666")) # manually coloring plots.

