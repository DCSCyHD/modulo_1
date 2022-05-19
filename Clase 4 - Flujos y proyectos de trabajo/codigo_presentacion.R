###################################### Código de la presentación
###CORRER EL CODIGO CON EL PROYECTO DE LA CLASE 4 ABIERTO!!! (clase_4_flujo_trabajo.Rproj)


#Cargo librerias ####
library(tidyverse)
library(openxlsx)

#Leo bases de datos####
inmuebles<- read_csv(
  file = "bases/inmuebles-estado-nacional.csv")  

comunas <- read.xlsx(xlsxFile = "bases/comunas.xlsx")

# Funciones para inspeccionar la base ####
## summary ####
inmuebles %>% 
  summary() 

## glimpse ####
inmuebles %>% 
  glimpse()

## sample_n ####
inmuebles %>% 
  sample_n(size = 10)

# Dataframes inventados ####

base_encuesta <- data.frame(
  sexo = sample(x = 1:2,size = 15,replace = T),
  edad = sample(x = 1:99,size = 15,replace = T),
  nivel_ed = sample(x = 1:7,size = 15,replace = T))

diccionario_niveles <- data.frame(nivel_ed = 1:7,
                                  nivel_ed_text = c(
                                    "Primaria incompleta",
                                    "Primaria completa",
                                    "Secundaria incompleta",
                                    "Secundaria completa",
                                    "Terc/Univ incompleta",
                                    "Terc/Univ completa",
                                    "Sin Instruccion")) 

diccionario_niveles_posgrad <- data.frame(
  nivel_ed = 8:9,
  nivel_ed_text = c("Posgrado incompleto",
                    "Posgrado completo"))

# Uniendo dataframes ####
## left_join ####

base_encuesta %>%  
  left_join(diccionario_niveles)

## bind_rows ####
diccionario_niveles %>% 
  bind_rows(diccionario_niveles_posgrad)

# Exportando objetos ####

## write.xlsx(x = objeto_resultados,file = "Resultados/cuadro1.xlsx")
## 
## saveRDS(object = objeto_resultados,file = "Resultados/base_nueva.RDS")
