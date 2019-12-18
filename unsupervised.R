
#Preparing data
library(ggplot2)
library(data.table)
library(fasttime)
data <- fread("data/sales_data_for_clustering.csv")
head(data)

#Convert purchase time to numeric and day of the week
data[, purchase_time := as.Date(fastPOSIXct(purchase_time))]
data[, purchase_time_n := as.numeric(purchase_time)]
data[, day := (purchase_time_n + 3) %% 7 +1]
data <- data[, -c("purchase_time", "purchase_time_n", "user_id", "product_id", "quantity")]
data_short <- data[1:20000]


##K-means 
km_output <- kmeans(data_short, centers = 2, nstart = 20)
km_output
km_output$cluster

## How to determine the number of clusters?
ks <- 1:5
tot_within_ss <- sapply(ks, function(k) {
    km_output <- kmeans(data_short, centers = k, nstart = 20)
    km_output$tot.withinss
})
tot_within_ss

plot(
    x = ks, 
    y = tot_within_ss, 
    type = "b", 
    xlab = "Values of K", 
    ylab = "Total within cluster sum of squares"
)

#Final plot
ggplot(data_short, aes(x = day, y = price)) +
    geom_point(colour = (km_output$cluster + 1), size = 2) 

#Conclusion
#The clustering happens between cheap and more expensive products. 



