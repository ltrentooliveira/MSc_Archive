# Exploratory Data Analysis ----------------------------------------------------
#### This code was developed to analyse the data input and visualize its descriptives

## IMPORT LIBRARIES-------------------------------------------------------------
library(tidyverse)
library(corrplot)
library(ggcorrplot)
library(knitr)
library(ggplot2)

## LOAD INPUT FEATURE TABLE-----------------------------------------------------
setwd("C:/Users/lorra/Documents/ITC/THESIS/ARCHIVE")
data <- read.csv("Input_variables.csv", header = TRUE)
head(data)

## CHECK DATA STRUCTURE---------------------------------------------------------
### Remove null values
data1 <- na.omit(data)
head
### Select specific features----------------------------------------------------
####This step varied according to the experiments and each specific features used
#### this example only selected some EO-based features
data2 <- data1 [ , 5:36] 
head(data2)
str(data2)
summary(data2)

## NORMALIZE THE DATA FRAME-----------------------------------------------------
data3 <- as.data.frame(scale(data2))
head(data3)
str(data3)

## VISUALIZE THE DATA WITH HISTOGRAMS-------------------------------------------
data3 %>%
  gather(Attributes, value, 1:32) %>%
  ggplot(aes(x=value, fill=Attributes)) +
  geom_histogram(colour="black", show.legend=FALSE) +
  facet_wrap(~Attributes, scales="free_x") +
  labs(x="Values", y="Frequency",
       title="Features - Histograms") +
  theme_bw()

## VISUALIZE THE DATA WITH DENSITY PLOTS----------------------------------------
data3 %>%
  gather(Attributes, value, 1:32) %>%
  ggplot(aes(x=value, fill=Attributes)) +
  geom_density(colour="black", alpha=0.5, show.legend=FALSE) +
  facet_wrap(~Attributes, scales="free_x") +
  labs(x="Values", y="Density",
       title="Features - Density plots") +
  theme_bw()

## VISUALIZE THE DATA WITH BOXPLOTS---------------------------------------------
data3 %>%
  gather(Attributes, values, c(1:32)) %>%
  ggplot(aes(x=reorder(Attributes, values, FUN=median), y=values, fill=Attributes)) +
  geom_boxplot(show.legend=FALSE) +
  labs(title="Features - Boxplots") +
  theme_bw() +
  theme(axis.title.y=element_blank(),
        axis.title.x=element_blank()) +
  ylim(-20, 20) + ####changeable according to the number of attributes
  coord_flip()

## CALCULATE PEARSON CORRELATION MATRIX-----------------------------------------
#### Final visualization was produced in Python with the following code:
####plt.figure(figsize=(30,15))
####cor = df.iloc[:,1:32].corr()
####sns.heatmap(cor, annot=True, cmap='coolwarm')
####plt.show()
#### where df is the dataframe ('Input_variables.csv' file)
ggcorrplot::ggcorrplot(cor(data3)) 

