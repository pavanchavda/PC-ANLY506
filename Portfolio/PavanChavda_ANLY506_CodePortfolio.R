#Installaing libraries
install.packages("dplyr")
install.packages("ggplot2")
install.packages("reshape2")

#Loading libraries
library(dplyr)
library(ggplot2)
library(reshape2)

#loading mtcars data in the environment


# Exploratory Data Analysis Checklist

#Step 1: Formulate your question.
##Is there any relationship between weigth of the car and its mileage

#Step 2: Read in your data
data(mtcars)

#Step 3: Check the packaging
nrow(mtcars)
ncol(mtcars)

#Step 4:Run str()
str(mtcars)

#Step 5: Look at the top and the bottom of your data
head(mtcars)
tail(mtcars)


#summary of the data by executing various functions
range(mtcars$mpg)
range(mtcars$hp)
range(mtcars$cyl)
range(mtcars$wt)

#Print observations for a variable in the dataset
table(mtcars$mpg)

#Creating visulizations using ggplot
g1 <- ggplot(mtcars, aes(mpg, wt, colour = cyl))+geom_point()
g1

#Adding some graphical elements such as labels, colors, title, etc
g1+labs(x = "Mileage", y = "Weight",title = "Relationship between weight and mileage of cars",colour="Cylinders")


#Using dplyr package to manage the dataframe
data("iris")
str(iris)
head(iris)
tail(iris)

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
  summarise(Sepal.Length=mean(Sepal.Length), Sepal.Width=mean(Sepal.Width))
avg
