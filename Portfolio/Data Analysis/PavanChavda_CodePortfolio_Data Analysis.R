#Course: ANLY 506 - Exploratory Data Analysis
#Title: Code portfolio_Data Analysis
#Author: Pavan Chavda
#Date: 04/14/2019

###Data Analysis###

# Exploratory Data Analysis Checklist

#Step 1: Formulate your question.
#Is there any relationship between weigth of the car and its mileage

#Step 2: Read in your data
data(flights)

#Step 3: Check the packaging
nrow(flights) #number of rows are as expected
ncol(flights) #number of columns are as expected 

#Step 4:Run str()
str(flights) #review the structure of the data

#Step 5: Look at the top and the bottom of your data
head(flights)
tail(flights)

#Step 6: Check your "n"s
unique(flights$carrier) #the dataset contains flights for 16 airline carrier


# Descriptive statistical Analysis
data("pirates")

#Pirates' average age
mean(pirates$age)

#Age range for pirates
range(pirates$age)

#Median weight of pirates
median(pirates$weight)

#Standard deviation of height of the pirates
sd(pirates$height)

#Summary of pirates age (min, 1st quartile, median, mean, 3rd quartile, max)
summary(pirates$age)

#Unique sword types
unique(pirates$sword.type)

#Count of pirates by their favourite sword type
table(pirates$sword.type)

#Basic scatter plot of height and weight of the pirates
plot(pirates$height,pirates$weight)

#Adding labels and title to the plot
plot(pirates$height,pirates$weight,
     main = "Height vs Weight of the pirates", 
     xlab = "height (cm)",
     ylab = "weight (kg)",
     col = "grey")

#Adding grids to the data
grid()

#Adding regression line to the plot
abline(lm(weight~height, pirates), col="black")


# Manhattan and Euclidean distances
a <- c(1,5,8,10)
b <- c(6,7,12,15)
m <- matrix(c(a,b), byrow = T, nrow = 2)

#Distance from user1 (U1) to the new user
d1 <- abs(m[1,1]-m[1,4]) + abs(m[2,1]-m[2,4])
d1
#Distance from user2 (U2) to the new user
d2 <- abs(m[1,2]-m[1,4]) + abs(m[2,2]-m[2,4])
d2
#Distance from user3 (U3) to the new user
d3 <- abs(m[1,3]-m[1,4]) + abs(m[2,3]-m[2,4])
d3
distance_vector <- c(d1,d2,d3)
#Checking which distance is the smallest one
min(distance_vector)
#For the new user, system should recommend user1 (U1)
#Calculating the Manhattan distance
dist(m, method = "manhattan")
#Calculating the Euclidean distance
dist(m, method = "euclidean")

