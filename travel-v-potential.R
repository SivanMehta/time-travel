library(ggplot2)
source("./compile.R")

overall.schedule %>%
  group_by(team) %>%
  summarise(distance = max(total.distance)) %>%
  arrange(-distance) %>%
  mutate(home.team = reorder(team, distance)) %>%
  na.omit() %>%
  left_join(park.distances, by = "home.team") %>%
  group_by(team) %>%
  summarise(total.distance = max(distance), avg.distance = mean(dist1)) %>%
  ggplot() +
    aes(x = total.distance, y = avg.distance, label = team) +
    geom_text() +
    labs(x = "Total Distance traveled (miles)", y = "Average Distance to other ballparks (miles)")
