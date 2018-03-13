library(ggplot2)
library(dplyr)

source("./compile.R")

overall.schedule %>%
  mutate(date = as.Date(START.DATE, "1970-01-01")) %>%
  ggplot() +
  geom_line(aes(x = date, y = total.distance, colour = team)) +
  geom_text(aes(label = team, colour = team, x = max(date), y = total.distance), hjust = -.1) +
  
  labs(x = "Date", y = "Total Distance Traveled")
