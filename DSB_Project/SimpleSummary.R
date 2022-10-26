# this is the term project of the course "Data Science for Biologist"

getwd() # check current work path
setwd("/Users/liuyue/DS4B_Project_EaBluebirds_ConstrucNoise/DSB_Project")

# load packages
library("ggplot2")
library("tidyverse")


# input dataset
AmbNois<-read.csv("/Users/liuyue/DS4B_Project_EaBluebirds_ConstrucNoise/DSB_Project/Data/Ambient_Noise.csv") # ambient noise level data set
AmbTemp<-read.csv("/Users/liuyue/DS4B_Project_EaBluebirds_ConstrucNoise/DSB_Project/Data/Ambient_Temp.csv")# ambient temperature data set
OccupNest<-read.csv("/Users/liuyue/DS4B_Project_EaBluebirds_ConstrucNoise/DSB_Project/Data/OccupiedNests.csv") # Occupied nests' information data set
ReprOut<-read.csv("/Users/liuyue/DS4B_Project_EaBluebirds_ConstrucNoise/DSB_Project/Data/ReproductionOutcome.csv") # Reproduction outcome data set


# Code for the figures in proposal: Simple summary stats of the data

# ------ Summarize the recorded nests' information: species and counts  
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
  geom_col()


# ------ counting number of nests in each treatment type
Treat_counts <- ReprOut %>% 
  group_by(Treatment_Type) %>% 
  summarise(totalRows = n()) %>% 
  arrange(Treatment_Type) # create a new table counts the number of nests in each treatment type
Treat_counts <- Treat_counts %>% rename(Nest_Counts = totalRows) # rename the second column
# create a plot shwoing the number of nests in each treatment type
ggplot(data = Treat_counts) + 
  aes(x =  Treatment_Type, y = Nest_Counts) +
  geom_col()


# ------ summary of reproduction outcome
head(ReprOut)
ReprOut <- ReprOut %>% mutate(HatchingRate = Hatched_Chicks/Produced_Eggs) # add a new column which calculates hatching rate for each nest
# create a plot counting the hatching rate for each treatment type
str(ReprOut)
# create a box plot summarize the hatching rate for each treatment types
ggplot(data = ReprOut) + 
  aes(x = Treatment_Type, y = HatchingRate) +
  geom_boxplot()


# ------ Summerize Ambient Noise level
head(AmbNois)
str(AmbNois)
ncol(AmbNois)
AmbNois <- select(AmbNois, -(X:X.5)) # delete last 6 blank columns
ncol(AmbNois) # check the new dataset's column 
AmbNois_Nest <- select(AmbNois, Box_ID, X1st_Average, X2nd_Average, X3rd_Average, X4th_Average, X5th_Average)
AmbNois_Nest
AmbNois_Nest # get a new data set contains average noise level (dbl) of each measurement
ncol(AmbNois_Nest)
AmbNois_Nest <- AmbNois_Nest %>% pivot_longer(cols = 2:6, names_to = "Measurment_Code", values_to = "Temperature") # reorganize the data set

# create a box-plot showing the average ambient noise level for each Box 
ggplot(data = AmbNois_Nest) + 
  aes(x = Box_ID, y = Temperature, group = Box_ID) +
  geom_boxplot() 
