
library(tidyverse)
library(data.table)

base_covid_total <- fread("Fuentes/Covid19Casos.csv", encoding = "UTF-8")

tabla_casos <- base_covid_total %>% 
  rename(provincia = residencia_provincia_nombre) %>% 
  group_by(provincia) %>% 
  summarise(confirmados = sum(clasificacion_resumen == "Confirmado"),
            fallecidos = sum(fallecido == "SI")) %>% 
  ungroup()



### Importo proyecciones
pob_est_2021 <- fread("Fuentes/estimacion_pob_2021_provincias.csv", header = T, encoding = "UTF-8")

### Tabla total
tabla_tot <- tabla_casos %>% 
  left_join(pob_est_2021, by = c("residencia_provincia_nombre" = "Provincia"))



### Corrijo columnas claves con diferente nombre
unique(tabla_casos$residencia_provincia_nombre)
unique(pob_est_2021$Provincia)

tabla_casos$provincia[tabla_casos$provincia == "Santa Fe"] <- "Santa Fé"
unique(tabla_casos$residencia_provincia_nombre)

readr::write_rds(tabla_casos, "Fuentes/tabla_casos_provinciales.rds")


### Tabla total - intento 2
tabla_tot <- tabla_casos %>% 
  left_join(pob_est_2021, by = c("residencia_provincia_nombre" = "Provincia")) %>% 
  mutate(tasa_confirmados = round(cantidad_confirmado / pob_estimada_2021 * 100, 2),
         tasa_fallecidos = round(cantidad_fallecido / pob_estimada_2021 * 100, 2))


  

class(tabla_tot$pob_estimada_2021)
