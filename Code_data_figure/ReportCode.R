# this is the term project of the course "Data Science for Biologist"
rm(list = ls())
getwd() # check current work path
setwd("/Users/liuyue/DS4B_Project_EaBluebirds_ConstrucNoise/Code_data_figure")

# load packages
library("ggplot2")
library("tidyverse")

# input dataset
OccupNest <- read.csv("./Data/OccupiedNests.csv") # Occupied nests' information data set
ReprOut <- read.csv("./Data/ReproductionOutcome.csv") # Reproduction outcome data set


# Code for the figures in presentation: 
# Simple summary stats of the data

# ----------------------
# Summarize the recorded nests' information: species and counts  
View(OccupNest)
str(OccupNest)
nrow(OccupNest)
head(OccupNest)
OccupNest %>% select(Species) %>% distinct()
Nest_Speci <- OccupNest %>% group_by(Species) %>% tally # create a new tables contains the counts of nest for each species
View(Nest_Speci) # check data structure
Nest_Speci <- Nest_Speci %>% rename(Nest_Counts = n) # rename the column
str(Nest_Speci)
# create a plot showing the number of nests per species
ggplot(data = Nest_Speci) + 
  aes(x = Species, y = Nest_Counts) +
  geom_col() +
  ylim(0,50)

# ---------------------
# summary of reproduction outcome
head(ReprOut)
ReprOut <- ReprOut %>% mutate(HatchingRate = Hatched_Chicks/Produced_Eggs) # add a new column which calculates hatching rate for each nest
# create a plot counting the hatching rate for each treatment type
str(ReprOut)

# ------------------
# counting number of nests in each playback status
ReprOut$playback <- "Yes" # add a new column showing the playback status
ReprOut$playback[ReprOut$Treatment_Type == "N"] <- "No" # change column value, if the treatment type is N, then the playback status is No
ReprOut$playback[ReprOut$Treatment_Type == "Q"] <- "No" # change column value, if the treatment type is Q, then the playback status is No
ReprOut
Playback_counts <- ReprOut %>% 
  group_by(playback) %>% 
  summarise(totalRows = n()) %>% 
  arrange(playback) # create a new table counts the number of nests with different playback status
Playback_counts <- Playback_counts %>% rename(Counts = totalRows)

# create a plot showing the number of nests in each playback status
colors <- c("orange","light blue") #set color design
ggplot(data = Playback_counts) +
  aes(x =  playback, y = Counts) +
  geom_col(fill=colors) +
  ylab("Number of nests")+
  xlab("Playback Status") +
  ylim(0,30)

# create a box plot summarize the hatching rate for groups with/without playback
ggplot(data = ReprOut) + 
  aes(x = playback, y = HatchingRate, fill = playback) +
  geom_boxplot() +
  xlab("Playback Status") +
  ylab("Hatching Rate")

# --------------- 
# counting number of nests in each treatment type
Treat_counts <- ReprOut %>% 
  group_by(Treatment_Type) %>% 
  summarise(totalRows = n()) %>% 
  arrange(Treatment_Type) # create a new table counts the number of nests in each treatment type
Treat_counts <- Treat_counts %>% rename(Nest_Counts = totalRows) # rename the second column
# create a plot showing the number of nests in each treatment type
ggplot(data = Treat_counts) + 
  aes(x =  Treatment_Type, y = Nest_Counts) +
  geom_col() +
  ylim(0, 15) +
  ylab("Number of nests")+
  xlab("Treatment types")

# create a box plot summarize the hatching rate for each noise gradient
ggplot(data = ReprOut) + 
  aes(x = Treatment_Type, y = HatchingRate, col = Treatment_Type) +
  geom_boxplot() +
  xlab("treatment types") +
  ylab("Hatching Rate")



