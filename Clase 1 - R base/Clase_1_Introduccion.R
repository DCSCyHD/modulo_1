# Carga de paquetes ####
A <- 1

A + 6

B <- 2
B

A <- 150
B <- 132

# Preprocesamiento ####

## Creo nueva columna ####
A = B # Ahora A toma el valor de B 
print(A)
#(B continua conservando el mismo valor)

#suma 
5+6
## Filtro salarios altos ####
#Resta
6-8

# Modelado de daots ####

#cociente
6/2

#multiplicacion
6*2

#Potencia
3^3


#Redefinimos los valores A y B
A <- 10
B <- 20

#Realizamos comparaciones lógicas
A > B
A >= B
A < B
A <= B
A == B # IMPORTANTE
A != B


C <- A != B
class(C)

#Redefinimos los valores A y B
A <- 50
B <- 72
#Realizamos comparaciones lógicas

(A > 60 & B > 65)
(A < 60 | B < 65) 
#MAYUSCULAS Y MINUSCULAS
a <- 90

rm(`mi numero`)
# INDICES DEL CODIGO

## Practica:     
#1) Crear un objeto llamado "mi_numero" que almecene un número que ustedes quieran. ¿Qué pasa si lo intentan nombrar como "mi numero"?         
#2) Realizar alguna operación matemática con el objeto y guardar el resultado como un nuevo objeto llamado "otro_numero".     
#3) Comprobar lógicamente si el segundo objeto es igual a 10.    
#4) Comprobar lógicamente si alguno de los dos objetos es mayor a 10 

mi_numero <- 888
#mi numero <-  88

otro_numero <- mi_numero*2

otro_numero == 10

(otro_numero > 10|mi_numero> 10)


A <- 1
class(A)

A <- "Hola, ¿qué tal?"

class(A)

class(Sys.Date())

# Vector numérico
vec_num <- c(1, 2, 2,2,3,2,1, 2, 1, 1, 1)
class(vec_num)

# Vector de caracteres
dias_char <- c("Lunes","Viernes","Viernes","Jueves",
               "Martes", "Martes","Miercoles",
               "Martes","Miercoles")
class(dias_char)

# Vector de tipo fecha
vec_fecha <- Sys.Date()+2

class(vec_fecha)


table(dias_char)

# Una propiedad del factor: las etiquetas.
dias_factor <- factor(dias_char,
                       c("Lunes",
                                 "Martes",
                                 "Miercoles",
                                 "Jueves",
                                 "Viernes"))

class(dias_factor)

table(dias_factor)

#as.numeric(dias_factor)

D <- c(1, 3, 4)
D <- D + c(2,2,2)
D
1:10
E <- D + 1:3 #esto es equivalente a hacer 3+1, 5+2, 6+3 
E

# Si quiero al valor 2 del objeto E:
E 
E[2]

E_posicion2 <-  E[2]
E_posicion2

rm(E_posicion2)
E_posicion2

E
E[2] <- "Pablo"
E

# Tener cuidado al modificar el tipo de uno de los valores y no el de todos los del objeto:
class(E)

## Practica:     
# 1) Crear un vector numerico de 7 valores, elegir numeros entre 1 y 50        
# 2) Comprobar logicamente cuales de ellos son menores a 25    
# 3) Extraer del vector el 3er y 5to valor      
# 4) Extraer del vector todos los valores menores a 25     

AGLOMERADO  <- c(32,33,33,33,32)

SEXO  <-  c("Varon","Mujer","Mujer","Varon","Mujer")

EDAD  <-  c(60,54,18,27,32)

Datos <- data.frame(AGLOMERADO, SEXO, EDAD)
Datos
class(Datos)

Datos[3,2]
Datos[4,3]

Datos$AGLOMERADO
class(Datos$AGLOMERADO)

Datos$AGLOMERADO[2]

Datos$AGLOMERADO[3,2]

Datos[Datos$AGLOMERADO==32, ]
subset(Datos,AGLOMERADO==32)

aglo32 <- subset(Datos,AGLOMERADO==32)

mean(aglo32$EDAD)
# mean(subset(Datos,AGLOMERADO==32)$EDAD) ## Otra forma de llegar a lo mismo


mean(Edad_Aglo32)

LISTA <- list(A,B,C,D,E,Datos$AGLOMERADO, DF = Datos)
LISTA

LISTA$DF
LISTA$DF$EDAD
LISTA$DF$EDAD[2]

LISTA[[6]]

LISTA[[6]][1]

LISTA[[7]][2]

LISTA[[7]][2,1]

paste("Pega","estas", 4, "palabras", sep = " ")

#Puedo concatenar caracteres almacenados en objetos
a <- c(1, 2, 3)
b <- "con"
c <- c(4, 5, 6)

paste(a,b,c,sep = "-")

# Paste0 pega los caracteres sin separador
paste0(a,b,c)

# Repasando un comando ya visto...
1:5

# Función para sumar
sum(1:5)

# Para calclar medias
mean(1:5)

#Maximo
max(Datos$EDAD)

#Valores únicos de un vector
unique(Datos$AGLOMERADO)

## Practica:     
# 1) Abrir la pequeña base "comunas.xlsx". Calcular el area promedio de las comunas        
# 2) Calcular el area total de la ciudad de buenos aires  
# 3) Crear un nuevo dataframe que contenga solo las columnas AREA y COMUNA 
# 4) Crear un nuevo dataframe que contenga las columnas donde el area sea mayor a 1,5 millon de metros cuadrados
