library(dplyr)
library(tidyr)
library(lubridate)

park.distances <- read.csv('./data/distance matrix.csv')
parks <- unique(park.distances$name)
park.distances <- park.distances %>%
  add_row(stad1 = 'lol', stad2 = 'lol2', name = parks, name.1 = parks, dist1 = 0)

teams <- tibble(team.name = list.files("./data")) %>%
  separate(team.name, "team.name", sep = ".csv", extra = "drop") %>%
  filter(team.name != 'distance matrix') %>%
  unlist()

get.total.distances <- function(team) {
  filename <- paste('./data/', team, '.csv', sep = "")
  data <- read.csv(filename)

  data %>%
    separate(LOCATION, 'park', sep = " - ", extra = "drop") %>%
    mutate(name = park, name.1 = lag(park)) %>%
    mutate(START.DATE = as.Date(START.DATE, format = "%m/%d/%y")) %>%
    left_join(park.distances) %>%
    na.omit() %>%
    mutate(total.distance = cumsum(dist1)) %>%
    mutate(team = team) %>%
    select(name, name.1, START.DATE, total.distance, team) %>%
    return()
}

overall.schedule <- tibble(name = NA, name.1 = NA, START.DATE = NA, total.distance = NA, team = NA)

for(team in teams) {
  team.schedule <- get.total.distances(team)
  overall.schedule <- rbind(overall.schedule, team.schedule)
}

overall.schedule %>%
  ggplot() +
    aes(x = as.Date(START.DATE, "1970-01-01"), y = total.distance, colour = team) +
    geom_line() +
    labs(x = "Date", y = "Total Distance Traveled")
