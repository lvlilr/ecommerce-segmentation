
# Load required libraries
library(ggplot2)
library(dplyr)

# Read the data
ecom_data <- read.csv("E-commerce Dataset.csv")
print("Dataset Summary:")

summary(ecom_data)
## Data structure
print("Data structure:")

str(ecom_data)
# Create a copy of the original data for clustering
clustering_data <- ecom_data

# Select relevant columns and handle missing values
kmeans_data <- clustering_data[, c("Sales", "Profit")]
complete_cases <- complete.cases(kmeans_data)
kmeans_data <- kmeans_data[complete_cases, ]

# Update the main dataset to match
clustering_data <- clustering_data[complete_cases, ]

# Apply K-means clustering
set.seed(123)
kmeans_model <- kmeans(kmeans_data, centers = 3, nstart = 25)

# Add cluster labels to the cleaned dataset
clustering_data$Cluster <- as.factor(kmeans_model$cluster)

# Display first few rows
print("First few rows of clustered data:")
head(clustering_data)

# Model evaluation
print("\nTotal within-cluster sum of squares:")
print(kmeans_model$tot.withinss)

# Visualizations
# Average Profit by Payment Method
avg_profit_payment <- clustering_data %>%
  group_by(Payment_method) %>%
  summarise(Average_Profit = mean(Profit, na.rm = TRUE))

# Bar plot for payment methods
ggplot(avg_profit_payment, aes(x = Payment_method, y = Average_Profit, fill = Payment_method)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Profit by Payment Method",
       x = "Payment Method",
       y = "Average Profit") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Scatter Plot of Clusters
ggplot(clustering_data, aes(x = Sales, y = Profit, color = Cluster)) +
  geom_point() +
  labs(title = "E-commerce Transaction Segmentation",
       x = "Sales (USD)",
       y = "Profit (USD)") +
  theme_minimal()

# Elbow Method
wcss <- vector()
for (i in 1:10) {
  kmeans_temp <- kmeans(kmeans_data, centers = i, nstart = 25)
  wcss[i] <- kmeans_temp$tot.withinss
}

# Elbow plot
plot(1:10, wcss, type = "b", pch = 19, frame = FALSE,
     xlab = "Number of Clusters",
     ylab = "Within-Cluster Sum of Squares",
     main = "Elbow Method for Optimal Clusters")

# Print analysis results
print("\nCluster sizes:")
print(table(clustering_data$Cluster))

print("\nCluster centers:")
print(kmeans_model$centers)

# Calculate cluster statistics
cluster_stats <- clustering_data %>%
  group_by(Cluster) %>%
  summarise(
    avg_sales = mean(Sales),
    avg_profit = mean(Profit),
    count = n()
  )

print("\nCluster Statistics:")
print(cluster_stats)
