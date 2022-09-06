pacman::p_load(tidyverse, jsonlite)
N <- 10000

metaculus_dat <- fromJSON("https://www.metaculus.com/api2/questions/5121/")
agi_probs <- metaculus_dat$community_prediction$full$y
agi_years <- sample(2020:2220, size=N, replace=TRUE, prob=agi_probs )
alignment_years <- rnorm(N, mean=2037, sd=10)

pred_tibble <- tibble(type="AGI", years = agi_years) %>% 
  bind_rows(tibble(type="Alignment", years=alignment_years) %>% filter(years > 2020))

ggplot(pred_tibble, aes(x=years, fill=type)) +
  geom_density(alpha=0.4)

mean(alignment_years < agi_years)
