## ----setup, message = FALSE,echo=FALSE----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,include = TRUE,message = FALSE)



## ----message=FALSE, warning=FALSE---------------------------------------------------------
library(tidyverse)
library(lubridate)
library(TTR)


## ----message=FALSE, warning=FALSE---------------------------------------------------------
base.covid <- readRDS("../Fuentes/base_covid_sample.RDS")


## -----------------------------------------------------------------------------------------
casos.por.dia <- base.covid %>% 
  filter(clasificacion_resumen == "Confirmado",
         fecha_diagnostico >= "2020-05-01") %>% 
  mutate(dia.de.semana = wday(fecha_diagnostico,label = TRUE)) %>% 
  group_by(fecha_diagnostico,dia.de.semana) %>% 
  summarise(casos = n()) %>% 
  ungroup() %>% 
  filter(fecha_diagnostico != max(fecha_diagnostico))

casos.por.dia



## -----------------------------------------------------------------------------------------
casos.media.movil <- casos.por.dia %>% 
  mutate(media.movil = SMA(x = casos,n = 7))
casos.media.movil


## ----echo=FALSE---------------------------------------------------------------------------
ggplot(casos.media.movil,aes(x = fecha_diagnostico))+
  labs(title = "Media móvil de 7 días  - Casos confirmados de Covid",
       subtitle = "Muestra del 2% de casos diarios por departamento. Total País",
       x = "Fecha",
       y = "Cantidad de casos confirmados")+
#geom_col(aes(y = casos))+
geom_line(aes(y = media.movil,colour =""))+
  theme(legend.position = "none")



