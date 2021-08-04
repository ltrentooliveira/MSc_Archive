# FEATURE IMPORTANCE TOOL-------------------------------------------------------
#### This code was developed to train a k-means model coupled with the feature
#### importance package to distinguish the most important features for each 
#### emerging cluster and increase the model interpretability
#### This code was repeated for every experiment with each respective input features


## IMPORT LIBRARIES-------------------------------------------------------------
library(tidyverse)
library(gridExtra)
library(GGally)
library(knitr)
library(githubinstall)
library(FeatureImpCluster)
library(flexclust)
library(grid)
library(lattice)
library(modeltools)
library(stats4)
library(factoextra)

##LOAD DATA---------------------------------------------------------------------
setwd("C:/Users/lorra/Documents/ITC/THESIS/ARCHIVE")
data <- read.csv("Input_variables.csv", header = TRUE)
head(data)

## MAINTAIN ONLY FEATURE VALUES COLUMNS-----------------------------------------
data1 <- data[ , 12:36] 
head(data1)

## NORMALIZE DATA---------------------------------------------------------------
data2 <- as.data.frame(scale(data1))
head(data2)

##*UNSUPERVISED MACHINE LEARNING*-----------------------------------------------
####The model is trained 20 times to provide a range of variations of the 
####importance of each feature

###SELECT K VALUE---------------------------------------------------------------
set.seed(10)
wss <- function(k) {
  kmeans(data2, k, nstart = 10)$tot.withinss
}
k.values <- 1:10
wss_values <- map_dbl(k.values,wss)

plot(k.values, wss_values,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")

###STRAIGHTFORWARD FEATURE IMPORTANCE TOOL--------------------------------------

####Train the model with kcca function------------------------------------------
res <- kcca(data2, k=4)

####Run FeatImpCluster package--------------------------------------------------
FeatureImp <- FeatureImpCluster(res,as.data.table(data2))
par(mar=c(10, 2, 2, 2))

####Visualize results-----------------------------------------------------------
plot(FeatureImp)
barplot(res)

###CLUSTER-FEATURE IMPORTANCE ITERATIONS (20 TIMES)-----------------------------

####Initialize the model--------------------------------------------------------
set.seed(10)
nr_seeds <- 20
seeds_vec <- sample(1:1000,nr_seeds)

####Train the model interactively-----------------------------------------------
savedImp <- data.frame(matrix(0,nr_seeds,dim(data2)[2]))
count <- 1
####Use the tool to take the cluster model and get variable importance----------
#####Turn features to a list then back to dataframe and add variables names to
#####each misclassification score
for (s in seeds_vec) {
  set.seed(s)
  res <- kcca(data2,k=4)
  set.seed(s)
  FeatureImp_res <- FeatureImpCluster(res,as.data.table(data2),sub = 1,biter = 1)
  savedImp[count,] <- FeatureImp_res$featureImp[sort(names(FeatureImp_res$featureImp))]
  count <- count + 1
}
####Visualize and save the results of each iteration----------------------------
names(savedImp) <- sort(names(FeatureImp_res$featureImp))
boxplot(savedImp)
write.csv(savedImp, file = "Feat_Imp.csv")
Feat_imp <- read.csv("Feat_imp.csv", header = TRUE)
Feat_imp2 <- feat_imp[, -1]

#####Use the boxplots to visualize the resulting data frame---------------------
Feat_imp2 %>%
  gather(Attributes, values, c(1:32)) %>%
  ggplot(aes(x=reorder(Attributes, values, FUN=median), y=values, fill=Attributes)) +
  geom_boxplot(show.legend=FALSE) +
  labs(title="Feature importance - Boxplots") +
  theme_bw() +
  theme(axis.title.y=element_blank(),
        axis.title.x=element_blank()) +
  ylim(0, 0.08) +
  coord_flip()
