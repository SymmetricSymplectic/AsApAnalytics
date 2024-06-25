


library(shiny)
library(shinyjs)
library(shinyWidgets)
library(shinythemes)
library(shinymanager)
library(htmlwidgets)
library(htmltools)
library(xts)
library(readxl)
library(forecast)
library(sweep)
library(zoo)
library(scales)
library(data.table)
#library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggfortify)
library(ggpubr)
library(png)
library(grid)
library(lubridate)
library(plotly)
library(TSstudio)
library(corrplot)
library(tsibble)
library(tibble)
library(readr)
#library(tidyr)
#sjplot for model info visualization
library(sjPlot)
library(sjmisc)
library(sjlabelled)
library(broom)
#para detectar multiples fechas
library(anytime)
#para bajar precios
library(rusquant)
#gestion db
library(RMySQL)
#visualizacion de performance
library(performance)
library(see)
library(qqplotr)
#annualizar series
library(PerformanceAnalytics)



asapadb_remote = dbConnect(MySQL(),  #remote is to be used for dbms
                           user='Felix', 
                           password='XkxY1BgiwXFpTWvF', 
                           dbname='SisAna', 
                           host='146.190.57.35',
                           port = as.numeric("3306"))
#asapadb_local = dbConnect(MySQL(), 
#                          user='root', 
#                          password='password', 
#                          dbname='SisAnaDB',
#                          host='localhost'
#                          )
dbDisconnectAll <- function(){
  ile <- length(dbListConnections(MySQL())  )
  lapply( dbListConnections(MySQL()), function(x) dbDisconnect(x) )
  cat(sprintf("%s connection(s) closed.\n", ile))
}


#newsapi
#d880ad52a6914735ad495090eea842ec
library(newsapi)
#api <-paste(Sys.getenv("NEWSAPI_KEY"))
api <-"d880ad52a6914735ad495090eea842ec"

#función para unir df
MyMerge <- function(x, y){
  df <- merge(x, y, by= "Date", all.x= TRUE, all.y= TRUE)
  return(df)
}

# function for setting initial common period as base period: 
baseperiod_function <- function(x, inputdate){
  # input: x: xts object
  # output: x_indexed, modified xts
  #x <-x[paste(inputdate, "/", sep = "")] if one wants inputdate to be starting year 
  x_indexed <- as.xts(apply(na.omit(x), 2, function(v) 100*v/v[paste(inputdate)]))
  return(x_indexed)
  
}
#percentchange function for ts
pch <- function(data, lag = 1) {
  # argument verification
  #data <- as.numeric(data)
  # return percent change
  (data / stats::lag(data, lag) - 1)*100
}
#annualize function for ts

annualize <- function(data, periods = 1, lag = 1) {
  # argument verification
  #data <- as.numeric(data)
  # return annualized percent change
  ((data / stats::lag(data, lag))^(periods/lag) - 1)*100
}







#function to turn forecast objects into arrays
gen_array <- function(forecast_obj){
  
  actuals <- forecast_obj$x
  lower <- forecast_obj$lower[,2]
  upper <- forecast_obj$upper[,2]
  point_forecast <- forecast_obj$mean
  
  cbind(actuals, lower, upper, point_forecast)
}

#función que cuenta número de meses entre fechas
elapsed_months <- function(end_date, start_date) {
  ed <- as.POSIXlt(end_date)
  sd <- as.POSIXlt(start_date)
  12 * (ed$year - sd$year) + (ed$mon - sd$mon)
}



# Init DB using credentials data
credentials <- data.frame(
  user = c("Salvador", "Felix", "Gabriel", "Graciela", "Erica", "ErnestoA", "ArturoM", "SaulC", "Johann", "AmaroR", "GabyOlv", "JALoaeza" ),
  password = c("asapa", "admin","d3G0c1YbhT", "gLbcyTUTe2", "i6dH7J3Z4d", "c1Pctiwh3b", "wJEAC0KCtM", "SHnbuokbvN", "eIlgXWzCvi", "jfhiIEkksh", "H3pKCjfbXJ", "vCNDr2pbYy"),
  # password will automatically be hashed
  admin = c(FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE),
  stringsAsFactors = FALSE
)


# Función para descargar la lista de tablas de la base de datos
descargar_lista_tablas <- function(db_driver, db_host, db_port, db_name, db_user, db_password, table_name) {
  # Abrir la conexión a la base de datos
  conexion_db <- dbConnect(db_driver, host = db_host, port = db_port, dbname = db_name, user = db_user, password = db_password)
  
  # Manejo de errores para asegurar que la conexión se cierre
  on.exit(dbDisconnect(conexion_db))
  
  # Descargar la lista de tablas
  tablelist <- dbReadTable(conn = conexion_db, name = table_name)
  
  return(tablelist)
}


# Función para descargar datos de las tablas según la lista de tablas
descargar_datos_db <- function(db_driver, db_host, db_port, db_name, db_user, db_password, tablelist) {
  # Abrir la conexión a la base de datos
  conexion_db <- dbConnect(db_driver, host = db_host, port = db_port, dbname = db_name, user = db_user, password = db_password)
  
  # Manejo de errores para asegurar que la conexión se cierre
  on.exit(dbDisconnect(conexion_db))
  
  # Crear una lista para almacenar las tablas
  database <- list()
  
  # Loop para cargar cada tabla de la lista
  for (i in 1:length(tablelist$index)) {
    table <- dbReadTable(conn = conexion_db, name = paste(tablelist$dbname[i]))
    assign(paste(tablelist$dfname[i]), table)
    database[[i]] <- get(tablelist$dfname[i])
    rm(list = paste(tablelist$dfname[i]))
    rm(table)
  }
  
  return(database)
}

# Variables para la conexión a la base de datos
db_driver <- MySQL()
db_host <- "146.190.57.35"
db_port <- as.numeric("3306")
db_name <- "SisAna"
db_user <- "Felix"
db_password <- "XkxY1BgiwXFpTWvF"
table_list_name <- "tablelist"  # Nombre de la tabla que contiene la lista de tablas


#logotipos y cosas gráficas extras
asapa <- png::readPNG("www/logotipo-asapa.png")
asapa_black <-png::readPNG("www/logotipo-asapa-min-black.png")
asapa_logo <- rasterGrob(asapa, x = .15, y = .15, height = .15, width = .15,
                         interpolate=TRUE)
asapa_logo_black <- rasterGrob(asapa_black, x = .15, y = .15, height = .15, width = .15,
                               interpolate=TRUE)
back_image <- png::readPNG("www/asapa_back.png")
#config del tema de ggplot2
#escala del texto en las gráficas de ggplot2
theme_set(theme_linedraw(base_size=19))

# Descargar la lista de tablas al iniciar la aplicación
tablelist <- descargar_lista_tablas(db_driver, db_host, db_port, db_name, db_user, db_password, table_list_name) 

rateslist <- filter(tablelist, rate == 1)
rateslist$index <- rownames(rateslist)

#create named vectors for shiny selectizer
rate_choices <- rateslist$index
names(rate_choices) <-rateslist$tablename

ind_choices <- tablelist$index
names(ind_choices) <-tablelist$tablename

#descargar metadata para actualización


#descargar tabla de metadatos sobre la bdd
meta_data <- dbReadTable(asapadb_remote, "cat_global")






