#install.packages("eph")
#install.packages("tidyverse")
library(eph)
library(tidyverse)

eph_3t2022 <-  eph::get_microdata(year = 2022,trimester = 3,type = "individual")

eph_3t2022$ESTADO %>% 
  table() %>%  
  prop.table() %>% 
  round(digits = 2)

b_eph_seleccion <- eph_3t2022 %>% 
  organize_labels()  %>%  # EPH
  select(CH04, CH06,PONDERA, ESTADO)

?calculate_tabulates

calculate_tabulates(base = b_eph_seleccion,
                    x = "ESTADO",
                    y ="CH04",
                    weights = "PONDERA",add.totals = "both")

b_eph_seleccion2 <- eph_3t2022 %>% 
  select(1, 3, 10)

base_ejercicio <- select(eph_3t2022,CODUSU, ESTADO, CH04, CAT_OCUP)

base_ejercicio2 <- eph_3t2022 %>%  
  select(ESTADO, CH04, CAT_OCUP)

base_mayores_14 <- eph_3t2022 %>%
  filter(CH06 >= 14 & CH04 ==1)

unique(base_mayores_14$CH06)

summary(base_ejercicio)

base_con_etiquetas<- base_ejercicio %>% 
  eph::organize_labels()

summary(base_con_etiquetas)

base_edad_jubil <- eph_3t2022 %>%
  filter((CH06 >= 65 & CH04 ==1) | (CH06 >= 60 & CH04 ==2) )

unique(eph_3t2022$AGLOMERADO)

mis_aglomerados <- eph_3t2022 %>%
  select(AGLOMERADO, CH04, CH06, ESTADO, PONDERA) %>%
  filter(AGLOMERADO  %in%  c(32,33,20,6))

base_con_ingtot <- eph_3t2022 %>%
  select(P21, TOT_P12) %>%
  mutate(ingreso_ocup_tot = P21 + TOT_P12,
         ingreo_al_cuadrado = P21 + 100,
         saludo = "Hola",
         saludo2 = "Gente",
         saludo_concat = paste(saludo,saludo2),
         P21 = P21-1000)

