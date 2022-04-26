## ----setup,include=FALSE-----------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ----message=FALSE, warning=FALSE--------------------------------------------------------
library(tidyverse)
base.covid <- readRDS('Fuentes/base_covid_sample.RDS')


## ----warning=FALSE-----------------------------------------------------------------------
if( 2+2 == 4){
  print("Todo marcha bien")
}



## ----warning=FALSE-----------------------------------------------------------------------
if( 2+2 == 148.24){
  print("R, tenemos un problema")
}



## ----------------------------------------------------------------------------------------
ultima.actualiz.base<- unique(base.covid$ultima_actualizacion)
ultima.actualiz.base


## ----------------------------------------------------------------------------------------

if (ultima.actualiz.base == Sys.Date()) {
    "Datos al día de hoy"
} else{
  Sys.Date() - ultima.actualiz.base 
}


## ----------------------------------------------------------------------------------------
suma <- function(valor1, valor2) {
  valor1+valor2
}


suma


## ----------------------------------------------------------------------------------------
suma(valor1 = 5,valor2 = 6)


## ----------------------------------------------------------------------------------------
funcion_prueba <- function(parametro1,parametro2) {
  paste(parametro1, parametro2, sep = " <--> ")
}

funcion_prueba(parametro1 = "A ver", parametro2 = "que pasa")



## ----------------------------------------------------------------------------------------
Otra_funcion_prueba <- function(parametro1,
                                parametro2 = "colgado") {
 
   paste(parametro1, parametro2, sep = ", ")
  
}


Otra_funcion_prueba(parametro1 = "Hola")



## ----------------------------------------------------------------------------------------
calcula_ratio <- function(vector) {
  
vector.max  <-   max(vector)
vector.min  <-   min(vector)

return(vector.max/vector.min)
}



## ----------------------------------------------------------------------------------------
ratio <- calcula_ratio(vector = c(1,2,3,4))

ratio


## ---- error=TRUE-------------------------------------------------------------------------
calcula_ratio(vector = c(1,2,3,4,"H"))


## ---- error=TRUE-------------------------------------------------------------------------
calcula_ratio <- function(vector) {
  
assertthat::assert_that(is.numeric(vector),
                        msg = "Ingresa un vector numérico")
  

vector.max  <-   max(vector)
vector.min  <-   min(vector)


return(vector.max/vector.min)
}

calcula_ratio(vector = c(1,2,3,4,"H"))



## ----------------------------------------------------------------------------------------
calcula_ratio(vector = c(1,2,3,4,0))


## ----------------------------------------------------------------------------------------
calcula_ratio <- function(vector) {
  
assertthat::assert_that(is.numeric(vector),
                        msg = "Ingresa un vector numérico")
  
if(any(vector==0)){

  warning("Mensaje: Hay un cero en tu vector, no lo tomo en cuenta para el calculo")
  vector <- vector[vector!=0]
  
}
vector.max  <-   max(vector)
vector.min  <-   min(vector)


return(vector.max/vector.min)
}



## ----------------------------------------------------------------------------------------
calcula_ratio(vector = c(456,78,1232,6565,12,0))


## ----warning=FALSE-----------------------------------------------------------------------
for(i in 1:10){
   print(i^2)
}


## ----------------------------------------------------------------------------------------
for(Valores in 1:10){
   print(Valores^2)
  
}


## ----------------------------------------------------------------------------------------
clasificacion.casos<- unique(base.covid$clasificacion_resumen)
clasificacion.casos


## ----fig.height=8------------------------------------------------------------------------
for(categoria in clasificacion.casos){
   
base.filtrada  <- base.covid %>% 
    filter(clasificacion_resumen  == categoria)  
    
if(categoria!= "Sin Clasificar"){ #No grafico los "Sin Clasificar"
  
hist(x = base.filtrada$edad,
     main = categoria,
     xlab = "Edad",
     xlim = c(0,130))

}

}


## ----------------------------------------------------------------------------------------
for(categoria in c("SI","NO")){
   
base.filtrada  <- base.covid %>% 
    filter(fallecido  == categoria)  
    
hist(x = base.filtrada$edad,
     main = paste0("Fallecido: ",categoria),
     xlab = "Edad",
     xlim = c(0,130))
}

