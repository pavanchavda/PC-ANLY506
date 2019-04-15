#Course: ANLY 506 - Exploratory Data Analysis
#Title: Code portfolio_Data Importing
#Author: Pavan Chavda
#Date: 04/14/2019


###### Data Importing ###### 
#In this section, I will look at different ways the data can be imported into R


#Setting work directory
setwd("D:/Pavan's Documents/ANLY 506")

#Get working directory
getwd()

#Importing data From a csv file in your working directory into R
ozone <- read.csv("income.csv")

#Importing csv data file interactively
data <- read.csv(choose.files())

#Importing data that comes in-built with R or with packages
data(mpg)

#Importing data Using tibble
mpg<-as_tibble(mpg)

#Importing csv files using readr package
ozone <- read_csv("ozone.csv", col_names = T)
head(ozone)

#Importing text file with a delimiter
c1 <- read.csv ("cluster_1.txt",sep = " ")
c2 <- read.csv("cluster_2.txt",sep = " ")
c3 <- read.csv("cluster_3.txt",sep = " ")

#Merging multiple data sets
c <- cbind(c1[,2],c2[,2],c3[,2])
str(c)

#writing data or output to a csv file in your working directory
write_csv(ozone,"ozonedata.csv" )


#Installaing libraries
install.packages("dplyr")
install.packages("nycflights13")
install.packages("yarrr")


#Loading libraries
library(dplyr)
library("nycflights13")
library("yarrr")


#loading data from the packages in the R environment
data(mtcars)
data(flights)
data(pirates)

