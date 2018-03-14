library(ggplot2)
library(dplyr)
library(directlabels)

source("./compile.R")

overall.schedule %>%
  mutate(date = as.Date(START.DATE, "1970-01-01")) %>%
  ggplot() +
  aes(x = date, y = total.distance, colour = team, group = team) +
  geom_line() +
  geom_dl(aes(label = team), method = list(dl.trans(x = x - .2), "last.points")) +
  
  labs(x = "Date", y = "Total Distance Traveled") +
  theme(legend.position = "none")
