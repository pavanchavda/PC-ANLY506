library(tidyverse)
library(reshape2)
library(nycflights13)
library(yarrr)
library(NbClust)
library(clustertend)
library(cluster)
library(factoextra)
library(gridExtra)

setwd("F:/HU/ANLY 506")

#### Data Visualization ####

#data visualization of mpg dataset
#Load the data in the environment
data(mpg)
#Review the strucure of the data
str(mpg)
#Check first few rows of the data
head(mpg)
#Check number of rows and columns in the data
nrow(mpg)
ncol(mpg)

#Scatter plot of engine size(displ) and highway mileage
ggplot(mpg) + geom_point(aes(displ, hwy))
#Scatterplot of class and drv
ggplot(mpg, aes(class, drv))+geom_point()

#Faceting data by class
ggplot(mpg)+geom_point(aes(displ, hwy))+facet_wrap(~class)

#Boxplot of highway mileage by class
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + geom_boxplot() 


#Bikevendors dataset
bikevendors <- read.csv("D:/Pavan's Documents/ANLY 506/bikeVendors.csv")

#Plotting a bar plot that shows count of bikes by frame type
ggplot(bikevendors) + geom_bar(aes(frame))

#count of bikes by category1 and category 2
ggplot(bikevendors) + geom_bar(aes(category1))+theme_classic() #more mountain bikes than road bikes
ggplot(bikevendors) + geom_bar(aes(category2))+theme_classic() #majority of the bikes are cross country, elite road, and endurance road

#Creating a histogram for price distribution with a binwidth of 500
ggplot(bikevendors) +
  geom_histogram(aes(x = price), binwidth = 500)+theme_classic()
#Reshaping the data from wide to long format
bikevendors2 <- melt(bikevendors,id.vars = c("model", "category1", "category2", "frame", "price"), variable.name = "vendor")

#boxplot of price and category1
boxplot(price~category1, data=bikevendors2, col="blue") #mountain bikes are more expensive than road bikes

#boxplot of price and category2
boxplot(price~category2, data=bikevendors2, col="blue") #Cross country race and over mountain bikes are the most expensive while sport bikes are least expesive


###Clustering 

###K-means clustering

df <- USArrests

#Removing NA from the dataset
df <- na.omit(df)

#Scaling the dataframe
df <- scale(df)

#Creating the distance matrix
distance <- get_dist(df)

#Creating a Visualization for the distance matrix
fviz_dist(distance, gradient = list(low = "pink", mid = "white", high = "red"))

#Computing the k-means
k <- kmeans(df, centers = 2, nstart = 25)
str(k)
k

#Visualizing the cluster
fviz_cluster(k, data = df)

#Creating clusters with different number of cluster
k2 <- kmeans(df, centers = 3, nstart = 25)
k3 <- kmeans(df, centers = 5, nstart = 25)
k4 <- kmeans(df, centers = 8, nstart = 25)

#Comparing these different clusters
p1 <- fviz_cluster(k, geom = "point", data = df) + ggtitle("k = 2")
p2 <- fviz_cluster(k2, geom = "point",  data = df) + ggtitle("k = 3")
p3 <- fviz_cluster(k3, geom = "point",  data = df) + ggtitle("k = 5")
p4 <- fviz_cluster(k4, geom = "point",  data = df) + ggtitle("k = 8")

grid.arrange(p1, p2, p3, p4, nrow = 2)

#Determining optimal clusters
#Elbow method
set.seed(123)

#Function to compute total within-cluster sum of square 
wss <- function(k) {kmeans(df, k, nstart = 10 )$tot.withinss}

# Computing and plotting wss for k = 1 to k = 15
k.values <- 1:15

#Extracting wss for 2-15 clusters
wss_values <- map_dbl(k.values, wss)
plot(k.values, wss_values, type="b", pch = 19, frame = FALSE, xlab="Number of clusters K", ylab="Total within-clusters sum of squares")
#Optimal number of clusters = 4

#Average silhouette method
#Function to compute average silhouette for k clusters
avg_sil <- function(k) {km.res <- kmeans(df, centers = k, nstart = 25)
ss <- silhouette(km.res$cluster, dist(df))
mean(ss[, 3])}

#Computing and plotting wss for k = 2 to k = 15
k.values <- 2:15

#Extract avg silhouette for 2-15 clusters
avg_sil_values <- map_dbl(k.values, avg_sil)
plot(k.values, avg_sil_values, type = "b", pch = 19, frame = FALSE, xlab = "Number of clusters K", ylab = "Average Silhouettes")

#Optimal number of clusters = 2
#Gap statistic method
#Computing gap statistic
set.seed(123)
gap_stat <- clusGap(df, FUN = kmeans, nstart = 25, K.max = 10, B = 50)
fviz_gap_stat(gap_stat)

#Optimal number of clusters = 4

#Hierarchical Clustering with R
# Dissimilarity matrix
d <- dist(df, method = "euclidean")

# Hierarchical clustering using Complete Linkage
hc1 <- hclust(d, method = "complete" )

# Plot the obtained dendrogram
plot(hc1, cex = 0.6, hang = -1)

# Compute with agnes
hc2 <- agnes(df, method = "complete")

# Agglomerative coefficient
hc2$ac

m <- c( "average", "single", "complete", "ward")
names(m) <- c( "average", "single", "complete", "ward")

# function to compute coefficient
ac <- function(x) {
  agnes(df, method = x)$ac
}

map_dbl(m, ac)

hc3 <- agnes(df, method = "ward")

pltree(hc3, cex = 0.6, hang = -1, main = "Dendrogram of agnes") 
hc4 <- diana(df)

# Divise coefficient; amount of clustering structure found
hc4$dc

# plot dendrogram
pltree(hc4, cex = 0.6, hang = -1, main = "Dendrogram of diana")

hc5 <- hclust(d, method = "ward.D2" )

# Cut tree into 4 groups
sub_grp <- cutree(hc5, k = 4)

# Number of members in each cluster
table(sub_grp)
