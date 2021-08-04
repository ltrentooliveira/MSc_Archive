# GLCM calculation -------------------------------------------------------------
#### Extracting hand-crafted texture features from Landsat PAN band ------------

## Import libraries-------------------------------------------------------------
library(glcm)
library(sp)
library(raster)
library(rgdal)
library(tiff)
library(ggplot2)

## Set repository---------------------------------------------------------------
setwd("C:/Users/lorra/Documents/ITC/THESIS/data/13.03/")

## Load, stack and visualize the input (Landsat 8 PAN band)---------------------
data <- stack("LC08_b08.tif")
data
plot(data)
data <- brick(data)

## Calculate the texture metrics using glcm package-----------------------------
#### input parameters n_grey, shift and na_opt are maintained in all iterations
#### but window is shifted in the six iterations from 3x3 to 13x13
textures <- glcm(raster("LC08_b08.tif"), n_grey = 32, window = c(13,13),
                 shift = c(1,1),
                 na_opt = "center")
## Determine the extension file that will save all textures---------------------
writeRaster(textures, filename = "b08_13x13.tif", overwrite = TRUE)
### stack all features into the raster file-------------------------------------
textures <- stack("b08_13x13.tif")
### Name the resulting bands of the raster file---------------------------------
names(textures) <- c("mean", "variance", "homogeneity", "contrast", "dissimilarity", "entropy", 
                     "second_moment", "correlation")
## Visualize the results--------------------------------------------------------
plot(textures)