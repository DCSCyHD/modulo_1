## ----setup, message = FALSE,echo=FALSE----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,include = TRUE,message = FALSE)


## ----message=FALSE,warning=FALSE----------------------------------------------------------
 #install.packages("rtweet")
library(tidyverse)
library(RVerbalExpressions)
library(rtweet) # (insalación no necesaria) descargar info de twitter
library(wordcloud2) #  (instalación opcional) para armar nube de palabras al final 


## -----------------------------------------------------------------------------------------
# chusmeen la cantidad de especificaciones que se le pueden dar a la funcion search_tweets

#?search_tweets 

 
# vacuna_tweets <- search_tweets(q = "vacuna",
#                                 n = 10000,
#                                 include_rts = FALSE,
#                                 lang ="es")

# saveRDS(vacuna_tweets,'../Fuentes/Bases adicionales/vacuna_tweets.RDS')

vacuna_tweets<- readRDS('bases/vacuna_tweets.RDS')


## -----------------------------------------------------------------------------------------
vacuna_tweets_select <- vacuna_tweets %>% 
  select(text,name,screen_name,created_at,location,
         favorite_count,retweet_count)

head(vacuna_tweets_select)


## -----------------------------------------------------------------------------------------
string1 <- c("SputnikV")
str_length(string1)


## -----------------------------------------------------------------------------------------
string2 <- "Sputnik V"
str_length(string2)

####
#Ejercicio: Crear en la base de datos una nueva columna que identifique en cada caso el largo del tweet. Luego, mostrar el o los casos de máxima longitud de esta variable.

## ----1er Ejercicio-----------------------------------------------------------


## -----------------------------------------------------------------------------------------
texto1 <- "qué"
texto2 <- "variantes?"

str_c(texto1,texto2)
str_c(texto1,texto2,sep = " ")


## -----------------------------------------------------------------------------------------

texto3 <- c("hace","loco","bien") 

str_c(texto1,texto3,sep = " ") # Vector de dimensión 3

str_c(texto1,texto3,sep = " ",collapse = " - ") # Vector de dimensión 1



## -----------------------------------------------------------------------------------------
telefonos <- c("4544-5645","4523-8972","4568-8945")
str_c("011-",telefonos)


## -----------------------------------------------------------------------------------------
#quiero el tercer caracter
string1
str_sub(string1,3,3)


## -----------------------------------------------------------------------------------------
#quiero del primero al cuarto
str_sub(string1,1,4)


## -----------------------------------------------------------------------------------------
#quiero la última y anteúltima posición
str_sub(string1,-2,-1)


## -----------------------------------------------------------------------------------------
string2
str_sub(string2,-1,-1) <- "?"
string2


## -----------------------------------------------------------------------------------------
string3 <- c(" vacunacion   ", "en   ",  "   argentina")
#Veamos el string
string3


## -----------------------------------------------------------------------------------------
str_trim(string3, side = 'both')


## -----------------------------------------------------------------------------------------
str_trim(string3, "left")


## -----------------------------------------------------------------------------------------
string1


## -----------------------------------------------------------------------------------------
#llevo todo a minúsculas
str_to_lower(string1)

## -----------------------------------------------------------------------------------------
#llevo todo a mayúsculas
str_to_upper(string1)

## -----------------------------------------------------------------------------------------
#llevo a mayúscula la primer letra de cada palabra
str_to_title("vacunación en argentina")


## 2do ejercicio ------------------------------------------------------------


## -----------------------------------------------------------------------------------------
tweets.ejemplo <- vacuna_tweets$text[1:3]
tweets.ejemplo


## -----------------------------------------------------------------------------------------
tweets.ejemplo.split <- str_split(tweets.ejemplo,pattern = " ")

tweets.ejemplo.split 


## -----------------------------------------------------------------------------------------
# Si queremos acceder al primer elemento de la lista
tweets.ejemplo.split[[1]]

## -----------------------------------------------------------------------------------------
# Si queremos acceder al primer elemento del primer elemento (vector) de la lista 
tweets.ejemplo.split[[1]][1]



## -----------------------------------------------------------------------------------------
primer.tweet<- tweets.ejemplo[1]
primer.tweet


## -----------------------------------------------------------------------------------------
# Reemplaza solo la primer ocurrencia.
str_replace(string = primer.tweet,
            pattern = "♥",
            replacement = "")


## -----------------------------------------------------------------------------------------
# Reemplazamos todas las ocurrencias de este patrón (en este caso sólo 1 caracter)
str_replace_all(string = primer.tweet,
                pattern = "♥️",
                replacement = "")



## 3er ejercicio------------------------------------------------------------

## -----------------------------------------------------------------------------------------
str_detect(tweets.ejemplo, "Astra")


## -----------------------------------------------------------------------------------------
base.filtrada <- vacuna_tweets %>% 
  filter(str_detect(string = text,
                    pattern =  "Astra"))

nrow(base.filtrada)


## -----------------------------------------------------------------------------------------
base.filtrada <- vacuna_tweets %>% 
  filter(str_detect(string = text,
                    pattern =  "Astra|astra"))

nrow(base.filtrada)

####Opción análoga
base.filtrada2 <- vacuna_tweets %>% 
  filter(str_detect(string = text, pattern = "(A|a)stra"))

nrow(base.filtrada2)


## -----------------------------------------------------------------------------------------
base.filtrada <- vacuna_tweets %>% 
  mutate(text = str_to_lower(text)) %>% 
  filter(str_detect(string = text, pattern = "astra"))

nrow(base.filtrada) # Ganamos más casos.


## -----------------------------------------------------------------------------------------
str_extract(tweets.ejemplo, "@")


## -----------------------------------------------------------------------------------------
str_extract_all(tweets.ejemplo, "@")


## -----------------------------------------------------------------------------------------
comienzan_c_mencion <- vacuna_tweets %>% 
  filter(str_detect(string = text, pattern = "^@"))

head(comienzan_c_mencion$text)


## ----include=FALSE------------------------------------------------------------------------
mencion_o_hashtag <- vacuna_tweets %>% 
  filter(str_detect(string = text, pattern = "^(@|#)"))%>%
  sample_n(6)

mencion_o_hashtag


## -----------------------------------------------------------------------------------------
vacuna_tweets %>% 
  filter(str_detect(string = text, pattern = "#COVID19$")) %>% 
  select(text)



## -----------------------------------------------------------------------------------------
vacuna_tweets %>% 
  filter(str_detect(string = text,
                    pattern = "^[[:digit:]]")) %>%
  select(text)


## -----------------------------------------------------------------------------------------
menciones <- rx() %>% 
  rx_find('@')%>% 
  rx_anything_but(value = ' ')

menciones


## -----------------------------------------------------------------------------------------
tweets.ejemplo


## -----------------------------------------------------------------------------------------
ejemplos.limpieza<- str_remove_all(tweets.ejemplo, pattern = menciones)
ejemplos.limpieza


## ----echo=TRUE----------------------------------------------------------------------------
hasthags <- rx() %>% 
  rx_find('#')%>% 
  rx_anything_but(value = ' ')

ejemplos.limpieza<- str_remove_all(ejemplos.limpieza, pattern = hasthags)
ejemplos.limpieza



###
tweets_limpios <- vacuna_tweets %>% 
  filter(!duplicated(text)) %>% 
  mutate(text = str_to_lower(text),
         text = str_remove_all(text, pattern = hasthags),
         text = str_remove_all(text, pattern = menciones),
         text = str_remove_all(text, pattern = "[^[:alnum:][:blank:]]")
  )

palabras<- tweets_limpios %>% 
  select(text) %>% 
  unnest_tokens(output = word,input = text)

head(palabras)

palabras_usuarios<- tweets_limpios %>% 
  select(text,screen_name) %>% 
  group_by() %>% 
  unnest_tokens(output = word,input = text)


stop_words <- read_delim('bases/stopwords.txt', 
                        delim = '\t',
                        col_names = c('word')) 

## Agregamos algunas palabras al listado de stopwords que queremos eliminar específicamente por nuestro dataset...
stop_words <- stop_words %>%
  add_row(word=c('vacuna',"vacunas"))

alabras_sin_stop_words <- palabras %>%
  anti_join(stop_words_agreg)

palabras_frecuentes <- palabras_sin_stop_words %>% 
  group_by(word) %>% 
  summarise(freq = n()) %>% 
  filter(freq>100) %>% 
  arrange(desc(freq)) 

wordcloud2::wordcloud2(vacunas_tidy) 
