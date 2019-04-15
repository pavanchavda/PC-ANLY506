#Course: ANLY 506 - Exploratory Data Analysis
#Title: Code portfolio_Data Wrangling
#Author: Pavan Chavda
#Date: 04/14/2019


#### Data Wrangling #####
library(tidyverse); library(reshape2); library(nycflights13)

#Creating matrix
a <- 1:5
b <- 6:10
c <- 11:15
cbind(a,b,c)
rbind(a,b,c)
x<-matrix(data = 1:15,
          nrow = 5,
          ncol = 3)
x #print matrix

#Slicing matrix
x[1,] #gives values in first row
x[,2] #gives values in second column
x[3,1] #gives value from 3rd row and first column


#Creating data frame
student <- c("Katy", "Matt", "Sam", "Brian", "Quin")
grade <- c("A", "B", "A", "F", "B")
df <- data.frame(student, grade, stringsAsFactors = FALSE)
df

#Slicing dataframes
df[2,] #returns second row from the data frame
df[,1] #returns first column from the data frame
df[4,1] #returns value from fourth row and first column

#Using dplyr to manipulate the data
data("iris")
str(iris) 
head(iris)

#Using Select function to select variables related to Sepal
iris1 <- iris %>%
  select(Species, Sepal.Length, Sepal.Width)

#Filtering the data for setosa species
iris2 <- iris %>%
  filter(Species=="setosa")

#Arranging the data frame for variable Species in descending order
iris3 <- iris %>%
  arrange(desc(Species))

#Using group_by() to group the data by a variable and summarize() to summarize the data frame for that variable
avg <- iris1 %>% 
  group_by(Species) %>%
  summarise(Sepal.Length=mean(Sepal.Length), Sepal.Width=mean(Sepal.Width)) %>%
  tally()
avg #returns the average value of Sepal width and sepal length

#Using mutate to add a new column
iris4 <- iris %>%
  mutate(newcolumn=Petal.Length*2)
head(iris4)


#nycflights13 dataset

#Loading the dataset flights
data(flights)

#Filtering using for December
dec <- filter(flights, month == 12)


#Exercises

#Filtering to flights with arrival delay of more than 2 hours
filter(flights, arr_delay >= 120)

#Filtering flights that flew to IAH or HOU
filter(flights, dest == "IAH" | dest == "HOU")

#Filtering flights operated by United, American or Delta
filter(flights, carrier == "UA" | carrier == "AA" | carrier == "DL")

#Filtering flights Departed in summer (July, August, and September)
filter(flights, month == 7 | month == 8 | month == 9)

#Filtering flights that arrived more than two hours late, but didn't leave late
filter(flights, arr_delay >= 120, dep_delay <= 0)

#Filtering flights that were delayed by at least an hour, but made up over 30 minutes in flight
filter(flights, arr_delay < 30, dep_delay >= 60)

#Filtering flights that departed between midnight and 6am
x1 <- filter(flights, dep_time >= 0000, dep_time <= 0600)
View (x1)

#Counting number of flights with missing departure time
sum(is.na(flights$dep_time))

#using arrange() to sort all missing values to the start? (Hint: use is.na()).
names(flights)[colSums(is.na(flights)) >0]
flights %>% 
  arrange(desc(is.na(dep_time)),
          desc(is.na(dep_delay)),
          desc(is.na(arr_time)), 
          desc(is.na(arr_delay)),
          desc(is.na(tailnum)),
          desc(is.na(air_time)))

#Sort flights to find the most delayed flights. Find the flights that left earliest.

arrange(flights, desc(dep_delay))
arrange(flights, arr_delay)

#Sort flights to find the fastest flights and shortest flights
arrange(flights, air_time)

#Using the dplyr's selct function

# Select columns by name
select(flights, dep_time, arr_time)

# Select all columns between year and day
select(flights, year, month, day)

# Select all columns except those from year to day
select(flights, -(year:day))
