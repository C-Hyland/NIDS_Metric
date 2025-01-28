---
title: "Corrie_Hyland_NIDS_R_code"
author: "Corrie Hyland"
date: "2024-08-12"
Citation: "__"
---

##Getting set up####  
rm(list=ls()) #refresh global environment
graphics.off() #refresh graphics
set.seed(1)

#Download tidyverse package and load to library#
#install.packages("tidyverse")
library(tidyverse)

#set your working directory
setwd("~/Example_folder/Example_subfolder")

---------------------------------------------------------------------------------------
  
##Import data ####
#Dataset set up as a csv. file with just d13C and d15N values, header included
Testdf <- read_csv("Book1.csv") #import small testing dataset

#Or example randomized dataset
set.seed(9810)

Testdf <- data.frame(
  d13C = round(runif(200, -20.6, -14.3), 1), # create random dataset where each
  d15N = round(runif(200, 5.3, 10.4), 1)) # row is a hypothetical specimen

---------------------------------------------------------------------------------------

##Create cluster Analysis####

dist_mat <- dist(Testdf, method = 'euclidean')#create distance matrix from base data

hclust_test <- hclust(dist_mat, method = 'average') #use UPGMA ('average') method of cluster analysis.
#?hclust()

#Optional plot the cluster analysis
plot(hclust_test)#plot to view cluster analysis

##Determine the NIDS Number for dataset####

NIDS <-2.5 #Set the NIDS cut-off value. Default is 1.5 following recommendations of Hyland et al. 2021

cut_NIDS <- cutree(hclust_test, h = NIDS)#set the desired NIDS metric using the "h = " input. 

max(cut_NIDS)
#?max

#Optional Plot the cluster analysis with the NIDS cut off: 1.5
plot(hclust_test)
rect.hclust(hclust_test, h = NIDS, border = 2:6)
abline(h = NIDS, col = 'red')

#Optional nicer colouring of cluster plot based on NIDS cut off: 1.5
#install.packages("dendextend")
library(dendextend)
NIDS_dend_obj <- as.dendrogram(hclust_test)
NIDS_dend_obj <- color_branches(NIDS_dend_obj, h = NIDS)
plot(NIDS_dend_obj)
abline(h = NIDS, col = 'red')

---------------------------------------------------------------------------------------

##Identify which samples correspond with each NIDS Cluster (NIDS: 1.5)#####
#install.packages("dplyr")
library(dplyr)

Testdf_cl <- mutate(Testdf, cluster = cut_NIDS) #adds column that identifies cluster number
count(Testdf_cl,cluster)#provides count of how many observations in each cluster

---------------------------------------------------------------------------------------
  
##Plot the range of d13C and d15N values within each cluster####
#install.packages("ggplot2")
library(ggplot2)

#the following plot is created using the uploaded csv. dataset that has headers for "d13C" and "d15N"
ggplot(Testdf_cl,
       aes(x=d13C, y = d15N, color = factor(cluster)))+
  geom_point(size = 3)+
  labs(
    x = "<i>δ</i><sup>13</sup>C (VPDB, ‰)",
    y = "<i>δ</i><sup>15</sup>N (AIR, ‰)",
    color = "NIDS Cluster") +
  theme(
    axis.title.x = ggtext::element_markdown(),
    axis.title.y = ggtext::element_markdown())+
  scale_fill_discrete(name = "NIDS Cluster")

---------------------------------------------------------------------------------------
##Reference to original Article####
#Hyland, C., Scott, M.B., Routledge, J. et al. Stable Carbon and Nitrogen Isotope Variability of Bone Collagen to Determine the Number of Isotopically Distinct Specimens. J Archaeol Method Theory 29, 666–686 (2022). https://doi.org/10.1007/s10816-021-09533-7
