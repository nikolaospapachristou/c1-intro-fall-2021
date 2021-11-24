library(tidyverse)
library(readxl)
library(janitor)

roster <- readxl::read_xlsx(here::here("nopublish", "groups.xlsx")) %>% 
  mutate(Student = paste(first, last))

random_draw <- function(x){
  repeat{
    groups <- as.character(x$group)
    x$samp <- sample(groups, replace = FALSE)
    x$check <- (x$group == x$samp)
    if (sum(x$check) == 0) break
  }
  return(x)
}

set.seed(651)
peer_review <- random_draw(roster)

peer_review %>% 
  select(Student, group = samp) %>% 
  left_join(select(roster, group, git_page, file)) %>% 
  select(student, `Repo to Review` = git_page, `File to Review` = file)
  distinct() 




  
  
