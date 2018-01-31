library(dplyr)
library(tidyr)
library(shiny)
library(zipcode)
library(ggplot2)
library(readr)
library(exploratory)
library(devtools)


veg <- read_csv("vegetarian_restaurants_final.csv")

#convert relevent columns in the "veg" data frame to "num" type
vegnum = as.data.frame(veg %>% select(.,city, lat, long, zip, state) %>% 
                         mutate(.,zip = readr::parse_number(zip)) %>% na.omit(.))

#gives top cities in terms of number of vegetarian restaurants
table1 = vegnum %>% select(city, state) %>% group_by(state) %>% arrange(city) %>% count(city) %>% 
  arrange(desc(n))

#creates a bar graph showing the top 10 cities in the US with vegetarian restaurants
table1plot = table1[1:10,]  %>% ggplot(aes(x=reorder(city,-n),y=n)) + 
  geom_bar(stat = "identity", fill="#0b69e5", colour="black") + 
  theme(axis.text.x = element_text(size = 15, angle = 90, hjust = 1),
        axis.text.y = element_text(size = 15),
        axis.title.x = element_text(size=15),
        axis.title.y = element_text(size = 15)) + 
  xlab("City") + ylab("Number of restaurants")
table1plot

#gives number of restaurants per state
vegnum %>% select(city, state) %>% group_by(state) %>% arrange(state) %>% count(state) %>% arrange(desc(n)) %>% 

#create a data frame of the data sorted by number of restaurants per state
table2 = vegnum %>% select(city, state) %>% group_by(state) %>% arrange(state) %>% count(state) %>% arrange(desc(n))

#gives a descending bar graph of number of vegetarian restaurants per state
table2plot = table2  %>% ggplot(aes(x=reorder(state,n),y=n)) + 
  geom_bar(stat = "identity", fill="#22e5bd", colour="black") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 20),
        axis.text.y = element_text(size = 13),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12)) + coord_flip() +
  xlab("City") + ylab("Number of restaurants")
table2plot



#gives city in each state with most restaurants
vegnum %>% select(city, state) %>% group_by(state) %>% arrange(city) %>% count(city) %>% 
  filter(., n==max(n)) %>% arrange(desc(n))  

#crete a table that shows the city in each state with the most vegetarian restaurants
table3 = vegnum %>% select(city, state) %>% group_by(state) %>% arrange(city) %>% count(city) %>% 
  filter(., n==max(n)) %>% arrange(desc(n))

#create a descending bar graph in order of the city with the most vegetarian restaurants per state
table3plot = table3  %>% ggplot(aes(x=reorder(city, n),y=n)) + geom_bar(stat = "identity",fill="#2263e5", colour="black") + 
  theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 16), 
        axis.text.y = element_text(colour="grey20",size=13,angle=0,hjust=1,vjust=0,face="plain"),
        axis.title.x = element_text(size=12),
        axis.title.y = element_text(size = 12)) + 
  coord_flip() +
  xlab("City") + ylab("Number of restaurants")
table3plot

