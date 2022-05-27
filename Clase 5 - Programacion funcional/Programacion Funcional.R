library(tidyverse)
library(openxlsx)
base.covid <- readRDS('bases/base_covid_sample.RDS')


if( 2+2 == 4){
  print("Todo marcha bien")
}



if( 2+2 == 148.24){
  print("R, tenemos un problema")
}


ultima.actualiz.base<- unique(base.covid$ultima_actualizacion)
ultima.actualiz.base


## -----------------------------------------------------------------

if (ultima.actualiz.base == Sys.Date()) {
    "Datos al día de hoy"
} else{
  paste0("Datos actualizados al ", ultima.actualiz.base) 
}


## -----------------------------------------------------------------
suma <- function(valor1, valor2) {
  valor1+valor2
}


suma


## -----------------------------------------------------------------
suma(valor1 = 5,valor2 = 6)


## -----------------------------------------------------------------
funcion_prueba <- function(parametro1,parametro2) {
  paste(parametro1, parametro2, sep = " <--> ")
}

funcion_prueba(parametro1 = "A ver", parametro2 = "que pasa")



## -----------------------------------------------------------------
Otra_funcion_prueba <- function(parametro1,
                                parametro2 = "colgado") {
 
   paste(parametro1, parametro2, sep = ", ")
  
}



## -----------------------------------------------------------------
Otra_funcion_prueba(parametro1 = "Hola")


## -----------------------------------------------------------------
calcula_ratio <- function(vector) {
  
vector.max  <-   max(vector)
vector.min  <-   min(vector)

return(vector.max/vector.min)
}



## -----------------------------------------------------------------
ratio <- calcula_ratio(vector = c(1,2,3,4))

ratio


## ---- --------------------------------------------------
calcula_ratio(vector = c(1,2,3,4,"H"))


## ---- --------------------------------------------------
calcula_ratio <- function(vector) {
  
assertthat::assert_that(is.numeric(vector),
                        msg = "Ingresá un vector numérico!")
  

vector.max  <-   max(vector)
vector.min  <-   min(vector)


return(vector.max/vector.min)
}

calcula_ratio(vector = c(1,2,3,4,"H"))



## -----------------------------------------------------------------
calcula_ratio(vector = c(1,2,3,4,0))


## -----------------------------------------------------------------
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



## -----------------------------------------------------------------
calcula_ratio(vector = c(1,2,3,4))


## ----------------------------------------------------
for(i in 1:10){
   print(i^2)

}


## -----------------------------------------------------------------
for(Valores in 1:10){
   print(Valores^2)
  
}


## -----------------------------------------------------------------
clasificacion.casos<- unique(base.covid$clasificacion_resumen)
clasificacion.casos


## -----------------------------------------------------------------
base.confirmados  <- base.covid %>% 
    filter(clasificacion_resumen  == "Confirmado")  
    
  
hist(x = base.confirmados$edad,
     main = "Casos Confirmados",
     xlab = "Edad",
     xlim = c(0,130))



## ----fig.height=8-------------------------------------------------
for(categoria in clasificacion.casos){
   
base.filtrada  <- base.covid %>% 
    filter(clasificacion_resumen  == categoria)  
    
  
hist(x = base.filtrada$edad,
     main = categoria,
     xlab = "Edad",
     xlim = c(0,130))


}


## -----------------------------------------------------------------
for(categoria in c("SI","NO")){
   
base.filtrada  <- base.covid %>% 
    filter(fallecido  == categoria)  
    
hist(x = base.filtrada$edad,
     main = paste0("Fallecido: ",categoria),
     xlab = "Edad",
     xlim = c(0,130))
}


## ----------------------------------------------------
cuadro_por_provincia<- base.covid %>% 
  group_by(residencia_provincia_nombre,clasificacion_resumen) %>% 
  summarise(casos = n())
  


---------------------------------------------
dir.create("Resultados")#Si quiero crear una nueva carpeta

openxlsx::write.xlsx(x = cuadro_por_provincia,
                     file ="Resultados/miexportacion.xlsx")



wb <- createWorkbook()

addWorksheet(wb,sheetName =  "Casos Provincias")

writeData(wb,
          sheet="Casos Provincias",
          x = "Cuadro 1. Cantidad de Casos por provincia", #Lo uso para crear un titulo
          startRow = 1)


writeData(wb,
          sheet="Casos Provincias",
          x = cuadro_por_provincia,   #Acá va la base de datos
          borders = "rows" ,#Parametro de Estilo
          borderStyle = "dashed", #Parametro de Estilo
          startRow = 3) #Dejo un espacio entre titulo y datos

saveWorkbook(wb, "Resultados/miexportacion_piola.xlsx")



provincias <- unique(cuadro_por_provincia$residencia_provincia_nombre)

wb <- createWorkbook() #Creo nuevo libro



for (prov in provincias) {

  #Este cuadro ira cambiando de provincia a medida que avanza el loop
cuadro.prov <- cuadro_por_provincia %>%
    filter(residencia_provincia_nombre == prov)

addWorksheet(wb, sheetName =  prov) #Al poner "prov" estoy agregando una pestaña con cada nombre de provincia

writeData(wb,                #Especifico mi base de datos
          sheet=prov,
          x = cuadro.prov,
          startRow = 1)

}

saveWorkbook(wb, "Resultados/miexportacion_loop.xlsx")


