library(ggplot2)
source("./compile.R")

overall.schedule %>%
  group_by(team) %>%
  summarise(distance = max(total.distance)) %>%
  arrange(-distance) %>%
  mutate(team = reorder(team, distance)) %>%
  na.omit() %>%
  ggplot() +
    aes(team, distance) +
    geom_col() +
    coord_flip() +
    labs(x = "Team", y = "Total Distance Traveled in Miles to all other parks")

