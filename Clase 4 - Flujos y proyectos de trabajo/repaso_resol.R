library(tidyverse)
library(openxlsx)

base.inmuebles <- read_csv("bases/inmuebles-estado-nacional.csv")

base.c.grupos <- base.argentina %>% 
  mutate(grupos_superficie = 
           case_when(
             superficie_aproximada_m2 < 1000 ~"Pequeña",
             superficie_aproximada_m2 >= 1000 & superficie_aproximada_m2 <= 15000~"Media",
             superficie_aproximada_m2 > 15000 ~"Grande"))


base.c.grupos %>% 
  group_by(provincia,grupos_superficie) %>% 
  summarise(casos = n()) %>% 
  ungroup() %>% 
  complete(provincia,grupos_superficie,fill = list("casos" = 0))