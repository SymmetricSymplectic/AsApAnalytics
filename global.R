


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
#sjplot for model info visualization
library(sjPlot)
library(sjmisc)
library(sjlabelled)
library(broom)
#para detectar multiples fechas
library(anytime)
#para bajar precios
library(quantmod)
#gestion db
library(RMySQL)

#asapadb_remote = dbConnect(MySQL(), 
#                    user='felix', 
#                    password='admin', 
#                    dbname='SisAnaDB', 
#                    host='143.198.144.181')
asapadb_local = dbConnect(MySQL(), 
                          user='root', 
                          password='password', 
                          dbname='SisAnaDB',
                          host='localhost'
                          )

#source("PREPROCESSING/balanza_proc.R", local = TRUE)
balanza_data <-dbReadTable(asapadb_local, "balanza_comercial")


source("PREPROCESSING/igae_proc.R", local = TRUE)
source("PREPROCESSING/igae1_proc.R", local = TRUE)
source("PREPROCESSING/pibmex_proc.R", local = TRUE)
source("PREPROCESSING/actind_proc.R", local = TRUE)
source("PREPROCESSING/imai_proc.R", local = TRUE)
source("PREPROCESSING/ifb_proc.R", local = TRUE)
source("PREPROCESSING/ifb(desest)_proc.R", local = TRUE)
source("PREPROCESSING/banxico_proc.R", local = TRUE)
source("PREPROCESSING/estab_proc.R", local = TRUE)
source("PREPROCESSING/imcp_proc.R", local = TRUE)
source("PREPROCESSING/imcp_desest_proc.R", local = TRUE)
source("PREPROCESSING/confianza_proc.R", local= TRUE)
source("PREPROCESSING/inpc_mensual_proc.R", local = TRUE)
source("PREPROCESSING/inf_mensual_proc.R", local = TRUE)
source("PREPROCESSING/inf_mensual_interanual_proc.R", local = TRUE)
source("PREPROCESSING/inf_anual_proc.R", local = TRUE)

source("PREPROCESSING/inpc_q_proc.R", local = TRUE)
source("PREPROCESSING/inf_q_proc.R", local = TRUE)
source("PREPROCESSING/sic_proc.R", local = TRUE)
source("PREPROCESSING/des_proc.R", local = TRUE)
source("PREPROCESSING/construc_proc.R", local = TRUE)
source("PREPROCESSING/automot_proc.R", local = TRUE)
source("PREPROCESSING/USA_proc.R", local = TRUE)



#metadata preproc
source("PREPROCESSING/metadata.R", local = TRUE)

database <- list(balanza_data,
                 establecimientos_data,
                 igae1_data,
                 igae_data,
                 actind_data,
                 imai_data,
                 imcp_data,
                 imcp_desest_data,
                 confianza_data,
                 inpc_mensual_data,
                 inpc_q_data,
                 inf_mensual_data,
                 inf_mensual_interanual_data,
                 inf_anual_data,
                 inf_q_data,
                 ifb_data,
                 ifbdesest_data,
                 pibmex_data,
                 reservas_data,
                 reservas_semanales_data,
                 remesas_fam_data,
                 sic_data,
                 des_data,
                 construc_data,
                 automot_data,
                 mtis_data,
                 consurvey_data,
                 conspending_data,
                 conscredit_data,
                 gdpindex_data,
                 gdp_data,
                 cpi_data,
                 ppi_data,
                 manuf_data,
                 unemp_data,
                 claims_data,
                 income_data,
                 wholesale_data,
                 retail_data,
                 advretail_data,
                 autos_data,
                 cpi_int_data
                 )






# Init DB using credentials data
credentials <- data.frame(
  user = c("Salvador", "Felix", "Gabriel", "Graciela", "Erica"),
  password = c("asapa", "admin","d3G0c1YbhT", "gLbcyTUTe2", "i6dH7J3Z4d"),
  # password will automatically be hashed
  admin = c(FALSE, TRUE, FALSE, FALSE, FALSE),
  stringsAsFactors = FALSE
)


# function for setting initial common period as base period: 
baseperiod_function <- function(x, inputyear){
  # input: x: xts object
  # output: x_indexed, modified xts
  x <-x[paste(inputyear, "/", sep = "")]
  x_indexed <- as.xts(apply(na.omit(x), 2, function(v) 100*v/v[1]))
  
  return(x_indexed)
  
}
#percentchange function for ts
pch <- function(data, lag = 1) {
  # argument verification
  #data <- as.numeric(data)
  # return percent change
  (data / lag(data, lag) - 1)*100
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
