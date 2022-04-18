#################Cargo librerias y descargo bases##############
library(eph)
library(tidyverse)

eph.t1.2019 <- get_microdata(year = 2019,
                             trimester = 1,
                             vars = c("ANO4","TRIMESTRE","CH04","CH06","REGION","AGLOMERADO","PONDERA"))

eph.t2.2019 <- get_microdata(year = 2019,
                             trimester = 2,
                             vars = c("ANO4","TRIMESTRE","CH03","CH04","CH06","REGION","AGLOMERADO","PONDERA"))

regiones.eph <- eph::diccionario_regiones

### Variables EPH en el ejercicio
# "CH03" (no la usaremos): Relacion de parentesco
# "CH04": Sexo. 1 - Varon, 2 - Mujer
# "CH06": Edad


#################Otras funciones útiles de tidyverse##############

####Bind rows########################################################
eph.t1t2 <- eph.t1.2019 %>% 
  bind_rows(eph.t2.2019) 

## ¿Que pasa si las bases tienen distintas cantidad de columnas,
## o se encuentran en otro orden?

# bind_rows busca nombre de columnas iguales para unir!!

#### ¿Cuantos casos muestrales y ponderados hay por región 
####  en cada trimestre?
casos.por.trimestre <- eph.t1t2 %>% 
  group_by(ANO4,TRIMESTRE,REGION) %>% 
  summarise(casos = n(),
            casos.ponderados = sum(PONDERA))


####Joins############################################################
#Quiero agregar la variable que me indica el nombre de region en el diccionario 

casos.por.trimestre.join <- casos.por.trimestre %>% 
  left_join(regiones.eph %>% rename(REGION = codigo)) 

####add_rows#############################################################
#Si necesito agregar a mano una fila a un dataframe
regiones.eph.soberania <- regiones.eph %>% 
  add_row(codigo = 100,
          region = "Malvinas")


####Otros ejercicios de práctica##################################


#Volver a la base de ambos trimestres.
#¿Cual es la maxima edad por sexo en cada trimestre?

maxima.edad.por.sexo <- eph.t1t2 %>% 
  group_by(ANO4,TRIMESTRE,CH04) %>% 
  summarise(edad.max = max(CH06))

# Elegir un trimestre y crear los siguientes rangos etarios#
#c("Menor a 25","26 a 35","36 a 45","46 a 55","56 a 65","65 o mas")

# Elaborar un objeto que muestre, por sexo, como se distribuye la población
# en estos rangos etarios.

eph.t1.rangos <- eph.t1.2019 %>% 
  mutate(
    rango.etario = factor(
      case_when(
      CH06 <= 25 ~ "Menor a 25",
      CH06 %in% 26:35 ~ "26 a 35",
      CH06 %in% 36:45 ~ "36 a 45",
      CH06 %in% 46:55 ~ "46 a 55",
      CH06 %in% 56:65 ~ "56 a 65",
      CH06 > 65 ~ "65 o mas"),
      levels = c("Menor a 25","26 a 35","36 a 45","46 a 55","56 a 65","65 o mas")
      )
    )

distrib.poblacional <- eph.t1.rangos %>% 
  group_by(ANO4,TRIMESTRE,CH04,rango.etario) %>% 
  summarise(personas = sum(PONDERA)) %>% 
  group_by(CH04) %>%
  mutate(Porcentaje = personas/sum(personas)) 
  
