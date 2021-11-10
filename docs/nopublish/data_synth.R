library(tidyverse)
library(haven)
library(rio)
library(synthpop)

data <- read_sav(here::here("C:/Users/jnese/Downloads/EDLD651 final project data.sav")) %>% 
  characterize()

data_r <- data %>%
  select(-id, -sl_avgsleep_bl) %>% 
  mutate(across(c(starts_with("io"), dm_lunch_bl), ~ifelse(. == "i don&#39;t know", "i don't know", .))) %>% 
  mutate(across(is.character, ~factor(.))) %>% 
  mutate(grade = factor(grade))

codebook.syn(data_r)

data_syn <- syn(data_r)

summary(data_syn)

compare(data_syn, data_r, stat = "counts")

write.syn(data_syn, file = "edld651_synthetic_data.csv", filetype = "csv")
