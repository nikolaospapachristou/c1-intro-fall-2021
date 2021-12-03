library(tidyverse)
library(readxl)


groups <- read_xlsx(here::here("nopublish", "groups.xlsx")) %>% 
  select(first, group) %>% 
  arrange(group, first) %>% 
  group_by(group) %>% 
  mutate(id = row_number()) %>%
  ungroup() %>% 
  pivot_wider(
    names_from = id,
    values_from = first
  ) %>% 
  unite("people", `1`:`5`, sep = ", ", na.rm = TRUE)

set.seed(651)
groups %>% 
  mutate(order = sample(c(1:length(group)))) %>% 
  arrange(order)

