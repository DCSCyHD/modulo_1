library(tidyverse)


options(scipen = 999)

##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##  ~ Cargo la base de trabajo  ----
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

base_inmuebles <- read.csv("bases/inmuebles-estado-nacional.csv") %>% 
  mutate(str_trim(calle))





base_inm_seleccion <- base_inmuebles %>% 
  select(codigo_del_inmueble, pais, provincia, departamento)


## --------------------------------------------------------------------
colnames(base_inm_seleccion)


## --------------------------------------------------------------------
colnames(base_inmuebles)


## ----echo = FALSE----------------------------------------------------
base_inm_seleccion2 <- base_inmuebles %>%
  select(1, 7, 8)


## --------------------------------------------------------------------
colnames(base_inm_seleccion2)


## ----select_1, include=FALSE-----------------------------------------
base_inmuebles %>% #BREAK
  select(8:10) #BREAK


## ----select_2, eval = F, echo = F------------------------------------
## base_inmuebles %>%
##   select(superficie_aproximada_m2:latitud)


## ----select_3, eval = F, echo = F------------------------------------
## base_inmuebles %>%
##   select(starts_with("s"))


## ----select_4, eval = F, echo = F------------------------------------
## base_inmuebles %>%
##   select(ends_with("o"))


## ----select_5, eval = F, echo = F------------------------------------
## base_inmuebles %>%
##   select(contains("it"))


## ----filter, eval = F, echo = F--------------------------------------
## base_inmuebles %>%
##   select(codigo_del_inmueble, pais) %>%  #BREAK
##   filter(pais == "Estados Unidos")


## ----filter_1, eval = F, echo = F------------------------------------
## base_inmuebles %>%
##   select(pais,
##          provincia,
##          situacion_inmueble) %>% #BREAK
##   filter(provincia %in% c("Cordoba","Buenos Aires")) %>% #BREAK
##   filter(situacion_inmueble == "Propiedad del ENA")


## ----mutate_1, eval = F, echo = F------------------------------------
## base_inmuebles %>%
##   select(pais, calle, numero) %>% #BREAK
##   filter(pais == "Argentina") %>% #BREAK
##   mutate(direccion = paste0(calle, " ", numero))


## ----echo=FALSE, fig.align = 'center', out.width='100%'--------------
knitr::include_graphics(here("img", "mutate_case.png"))


## ----mutate_2, eval = F, echo = F------------------------------------
## base_inmuebles %>%
##   select(pais, situacion_inmueble) %>% #BREAK
##   mutate(sit_inmb_2 = case_when(situacion_inmueble == "Propiedad del ENA" ~ "Propio",
##                                 situacion_inmueble == "Alquilado" ~ "Alquilado"))


## --------------------------------------------------------------------
summary(base_inmuebles$superficie_aproximada_m2)


## ----mutate_3, eval = F, echo = F------------------------------------
## base_inmuebles %>%
##   select(pais, superficie_aproximada_m2) %>% #BREAK
##   mutate(sup_rango = case_when(superficie_aproximada_m2 %in% c(0:200)   ~ "0 a 400",
##                                superficie_aproximada_m2 %in% c(201:400) ~ "401 a 800",
##                                superficie_aproximada_m2 %in% c(401:600) ~ "801 a 1200",
##                                superficie_aproximada_m2 %in% c(601:800) ~ "1201 a 1400",
##                                superficie_aproximada_m2 > 800           ~ "Mayor a 1400"))


## ----mutate_4, eval = F, echo = F------------------------------------
## base_inmuebles %>%
##   select(pais, superficie_aproximada_m2) %>% #BREAK
##   mutate(superficie_aproximada_m2 = round(superficie_aproximada_m2, digits = 0)) %>% #BREAK
##   mutate(sup_rango = case_when(superficie_aproximada_m2 %in% c(0:200)   ~ "0 a 400",
##                                superficie_aproximada_m2 %in% c(201:400) ~ "401 a 800",
##                                superficie_aproximada_m2 %in% c(401:600) ~ "801 a 1200",
##                                superficie_aproximada_m2 %in% c(601:800) ~ "1201 a 1400",
##                                superficie_aproximada_m2 > 800           ~ "Mayor a 1400"))


## ----summarise_1, eval = F, echo = F---------------------------------
## base_inmuebles %>%
##   select(codigo_del_inmueble, superficie_aproximada_m2) %>% #BREAK
##   summarise(min = min(superficie_aproximada_m2, na.rm = TRUE),
##             max = max(superficie_aproximada_m2, na.rm = TRUE),
##             media = mean(superficie_aproximada_m2, na.rm = TRUE),
##             mediana = median(superficie_aproximada_m2, na.rm = TRUE),
##             desvio = sd(superficie_aproximada_m2, na.rm = TRUE),
##             cv = desvio / media * 100)


## ----group_by_1, eval = F, echo = F----------------------------------
## base_inmuebles %>%
##   select(codigo_del_inmueble, situacion_inmueble, superficie_aproximada_m2) %>% #BREAK
##   group_by(situacion_inmueble) %>%
##   summarise(min = min(superficie_aproximada_m2, na.rm = TRUE),
##             max = max(superficie_aproximada_m2, na.rm = TRUE),
##             media = mean(superficie_aproximada_m2, na.rm = TRUE),
##             mediana = median(superficie_aproximada_m2, na.rm = TRUE),
##             desvio = sd(superficie_aproximada_m2, na.rm = TRUE),
##             cv = desvio / media * 100)


## ----group_by_2, eval = F, echo = F----------------------------------
## base_inmuebles %>%
##   select(pais, provincia, situacion_inmueble, superficie_aproximada_m2) %>% #BREAK
##   filter(pais == "Argentina") %>%
##   filter(superficie_aproximada_m2 < 10000) %>% #BREAK
##   mutate(provincia = case_when(provincia == "Ciudad Autonoma de Buenos Aires" ~ "CABA",
##                                TRUE ~ provincia),
##          situacion_inmueble = case_when(situacion_inmueble == "Propiedad del ENA" ~ "Propio",
##                                         situacion_inmueble == "Alquilado" ~ situacion_inmueble)) %>% #BREAK
##   group_by(provincia, situacion_inmueble) %>%
##   summarise(cantidad = n(),
##             media_sup_mts2 = mean(superficie_aproximada_m2, na.rm = TRUE)) %>% #BREAK
##   arrange(-cantidad) #BREAK



## ----pivot_longer_1, eval = F, echo = F------------------------------
## base_inmuebles %>%
##   select(codigo_del_inmueble, situacion_inmueble, superficie_aproximada_m2) %>% #BREAK
##   group_by(situacion_inmueble) %>%
##   summarise(min = min(superficie_aproximada_m2, na.rm = TRUE),
##             max = max(superficie_aproximada_m2, na.rm = TRUE),
##             media = mean(superficie_aproximada_m2, na.rm = TRUE),
##             mediana = median(superficie_aproximada_m2, na.rm = TRUE),
##             desvio = sd(superficie_aproximada_m2, na.rm = TRUE),
##             cv = desvio / media * 100) %>%
##   select(situacion_inmueble, media, mediana, desvio) %>% #BREAK
##   pivot_longer(cols = c(media, mediana, desvio), #<<
##                names_to = "variable",
##                values_to = "valor")


## ---- echo = F-------------------------------------------------------
base_largo <- base_inmuebles %>%
  select(codigo_del_inmueble, situacion_inmueble, superficie_aproximada_m2) %>% #BREAK
  group_by(situacion_inmueble) %>% 
  summarise(min = min(superficie_aproximada_m2, na.rm = TRUE),
            max = max(superficie_aproximada_m2, na.rm = TRUE),
            media = mean(superficie_aproximada_m2, na.rm = TRUE),
            mediana = median(superficie_aproximada_m2, na.rm = TRUE),
            desvio = sd(superficie_aproximada_m2, na.rm = TRUE),
            cv = desvio / media * 100) %>% 
  select(situacion_inmueble, media, mediana, desvio) %>% #BREAK
  pivot_longer(cols = c(media, mediana, desvio), #<<
               names_to = "variable",
               values_to = "valor")


## ----pivot_wider_1, eval = F, echo = F-------------------------------
## base_largo %>%
##   pivot_wider(names_from = "variable", #<<
##               values_from = "valor")

