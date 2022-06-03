## ----setup, message = FALSE,echo=FALSE-------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,include = TRUE,message = FALSE)



## ----message=FALSE, warning=FALSE------------------------------------------------------------------------
library(tidyverse)
library(lubridate)


## ----message=FALSE, warning=FALSE------------------------------------------------------------------------
base.covid <- readRDS("bases/base_covid_sample.RDS")
vacuna.tweets <- readRDS("bases/vacuna_tweets.RDS")


## ----eval=FALSE, message=FALSE, warning=FALSE, include=FALSE---------------------------------------------
## # covid.confirmado <- base.covid %>%
## #   filter(clasificacion_resumen == "Confirmado")
## #
## # a <- ggplot(covid.confirmado,aes(x = fecha_apertura))+
## #   labs(title = "Cantidad de casos confirmados segun fecha de apertura",
## #        subtitle = "Muestra del 2% de casos diarios por departamento",
## #        x = "Fecha",
## #        y = "Cantidad de casos confirmados")+
## # geom_histogram(binwidth = 1)
## 
## #ggsave(a,filename = "img/casos_confirmados.png",width = 15,height = 9)


## --------------------------------------------------------------------------------------------------------
range(base.covid$fecha_apertura)


## --------------------------------------------------------------------------------------------------------
class(base.covid$fecha_apertura)


## --------------------------------------------------------------------------------------------------------
range(vacuna.tweets$created_at)


## --------------------------------------------------------------------------------------------------------
class(vacuna.tweets$created_at)


## --------------------------------------------------------------------------------------------------------
today()
now()


## ----echo=TRUE,error=TRUE--------------------------------------------------------------------------------
comienzo_material <- "2021-04-20"

today() - comienzo_material  


## --------------------------------------------------------------------------------------------------------
#Distintas variantes que admite la función
ymd(20210420)  
ymd("20210420")
ymd("2021/04/20")


## --------------------------------------------------------------------------------------------------------
today() - ymd(20210420)


## --------------------------------------------------------------------------------------------------------
ejemplo2 <- "20/05/2020 18:20:40"
class(ejemplo2)


## --------------------------------------------------------------------------------------------------------
ejemplo2_ok<- dmy_hms(ejemplo2)
ejemplo2_ok
class(ejemplo2_ok)


## --------------------------------------------------------------------------------------------------------
vector_fechas_importado <- c("Apr-20","May-20","Jun-20") 

parse_date_time(vector_fechas_importado, orders = 'my')


## --------------------------------------------------------------------------------------------------------
fechas_1<- c("05-04-2021","01-01-1959","08-03-1917","09-14-1867")
fechas_2<- c("22-06-1986 19:06:00","22-06-1986 19:10:15",
                "09-12-2018 22:02:10")
fechas_3 <- c("2020-April-10","2020/May/11","2020-June 12")


## ----eval=FALSE, message=FALSE, warning=FALSE, include=FALSE---------------------------------------------
## mdy(fechas1)
## dmy_hms(fechas_hora)
## parse_date_time(fechas_3, orders = 'ymd')


## ----warning=FALSE---------------------------------------------------------------------------------------
base.covid.fechas<- base.covid %>% 
  mutate(anio = year(fecha_apertura),
         semestre  = semester(fecha_apertura),
         trimestre = quarter(fecha_apertura),
         mes       = month(fecha_apertura),
         mes.nombre = month(fecha_apertura,label = TRUE),
         dia.del.mes       = mday(fecha_apertura),
         dia.del.anio      = yday(fecha_apertura),
         semana       = week(fecha_apertura),
         dia.numero= wday(fecha_apertura),
         dia.nombre= wday(fecha_apertura, label = TRUE),
         hora = hour(fecha_apertura),
         minutos = minute(fecha_apertura))




## --------------------------------------------------------------------------------------------------------
base.covid.fechas %>% 
  select(fecha_apertura,trimestre,semana,dia.del.anio,dia.nombre,hora,minutos)


## ----eval=FALSE, warning=FALSE, include=FALSE------------------------------------------------------------
## ejercicio <- base.covid.fechas %>%
##   filter(anio == 2021, semana %in%  4:8)
## 
## ejercicio %>%
##   group_by(semana,dia.nombre) %>%
##   summarise(cantidad = n())


## --------------------------------------------------------------------------------------------------------
fecha <- base.covid$fecha_apertura[3]
fecha


## --------------------------------------------------------------------------------------------------------
fecha+ days(2) # Le sumo dos días a la fecha
fecha+ months(1) + days(7)  # Le sumo un mes y una semana a la fecha


## ----eval=FALSE, warning=FALSE, include=FALSE------------------------------------------------------------
## base.filtrada <- base.covid %>%
##   filter(fecha_apertura + days(7) < fecha_diagnostico)
## nrow(base.filtrada)


## --------------------------------------------------------------------------------------------------------
months(1)
years(2) + months(10) + hours(10)


## --------------------------------------------------------------------------------------------------------
treinta.enero.2021 <- dmy("30-01-2021") 

treinta.enero.2021 + months(1) # Intenta crear la fecha 30 de febrero. Error


## --------------------------------------------------------------------------------------------------------
treinta.enero.2021 + days(30)


## --------------------------------------------------------------------------------------------------------
base.covid.fechas <-  base.covid.fechas %>% 
  mutate(tiempo.diagnostico = fecha_diagnostico - fecha_inicio_sintomas)  

tiempo.diagnost.prom <- mean(base.covid.fechas$tiempo.diagnostico,
                             na.rm = TRUE)

tiempo.diagnost.prom


## --------------------------------------------------------------------------------------------------------
class(tiempo.diagnost.prom)


## --------------------------------------------------------------------------------------------------------
as.duration(tiempo.diagnost.prom)


## --------------------------------------------------------------------------------------------------------
dminutes(20)
dweeks(10)
dyears(1)
60*60*24*365


## --------------------------------------------------------------------------------------------------------
dmy_hms("29-02-2020 00:00:00") #Podemos construir la fecha 29 de febrero.


## --------------------------------------------------------------------------------------------------------
dmy_hms("28-02-2020 00:00:00") + years(1)
dmy_hms("28-02-2020 00:00:00") + dyears(1)


