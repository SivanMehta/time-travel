library(ggplot2)
library(dplyr)

park.distances <- read.csv('./data/distance matrix.csv')

park.distances %>%
  group_by(name) %>%
  summarise(distance = mean(dist1)) %>%
  arrange(-distance) %>%
  mutate(name = reorder(name, distance)) %>%
  ggplot() +
    aes(name, distance) +
    geom_col() +
    coord_flip() + 
    labs(x = "Park", y = "Distance in Miles")
  