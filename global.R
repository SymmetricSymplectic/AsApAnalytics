


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
                           user='asapacom_Felix', 
                           password='zPySwGE4GUHQ7v9', 
                           dbname='asapacom_SisAna', 
                           host='www.asapa.com')
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
  (data / lag(data, lag) - 1)*100
}
#annualize function for ts

annualize <- function(data, periods = 1, lag = 1) {
  # argument verification
  #data <- as.numeric(data)
  # return annualized percent change
  ((data / lag(data, lag))^(periods/lag) - 1)*100
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

balanza_data <- dbReadTable(asapadb_remote, "balanza_com_data")
igae_data <-dbReadTable(asapadb_remote, "igae_data")
igae1_data <-dbReadTable(asapadb_remote, "igae1_data")
actind_data <-dbReadTable(asapadb_remote, "actind")
imai_data <-dbReadTable(asapadb_remote, "imai")
ifb_data <-dbReadTable(asapadb_remote, "ifb")
ifbdesest_data <-dbReadTable(asapadb_remote, "ifbdesest")
pibmex_data<-dbReadTable(asapadb_remote, "pibmex_data")
reservas_data<- dbReadTable(asapadb_remote, "reservas_data")
reservas_semanales_data <- dbReadTable(asapadb_remote, "reservas_semanales_data")
remesas_fam_data<- dbReadTable(asapadb_remote, "remesas_fam_data")
establecimientos_data <- dbReadTable(asapadb_remote, "establecimientoscomerciales_data")
imcp_data <- dbReadTable(asapadb_remote, "IMCP_originales_data")
imcp_desest_data<- dbReadTable(asapadb_remote, "IMCP_desest_data")
confianza_data <- dbReadTable(asapadb_remote, "confianza_data")
inpc_mensual_data<- dbReadTable(asapadb_remote, "inpc_mensual_data")
inpc_q_data<- dbReadTable(asapadb_remote, "inpc_q_data")
inf_mensual_data<- dbReadTable(asapadb_remote, "inf_mensual_data")
inf_mensual_interanual_data<- dbReadTable(asapadb_remote, "inf_mensual_interanual_data")
inf_anual_data<- dbReadTable(asapadb_remote, "inf_anual_data")
inf_q_data<- dbReadTable(asapadb_remote, "inf_q_data")
pibmex_data<- dbReadTable(asapadb_remote, "pibmex_data")
sic_data<- dbReadTable(asapadb_remote, "sic_data")
des_data<- dbReadTable(asapadb_remote, "des_data")
construc_data<- dbReadTable(asapadb_remote, "construc_data")
automot_data<- dbReadTable(asapadb_remote, "automot_data")
mtis_data<- dbReadTable(asapadb_remote, "mtis_data")
consurvey_data<- dbReadTable(asapadb_remote, "consurvey_data")
conspending_data<- dbReadTable(asapadb_remote, "conspending_data")
conscredit_data<- dbReadTable(asapadb_remote, "conscredit_data")
#gdpindex_data,
gdp_data<- dbReadTable(asapadb_remote, "gdp_data")
cpi_data<- dbReadTable(asapadb_remote, "cpi_data")
ppi_data<- dbReadTable(asapadb_remote, "ppi_data")
manuf_data<- dbReadTable(asapadb_remote, "manuf_data")
unemp_data<- dbReadTable(asapadb_remote, "unemp_data")
claims_data<- dbReadTable(asapadb_remote, "claims_data")
income_data<- dbReadTable(asapadb_remote, "income_data")
wholesale_data<- dbReadTable(asapadb_remote, "wholesale_data")
retail_data<- dbReadTable(asapadb_remote, "retail_data")
advretail_data<- dbReadTable(asapadb_remote, "advretail_data")
autos_data<- dbReadTable(asapadb_remote, "autos_data")
cpi_int_data<- dbReadTable(asapadb_remote, "cpi_int_data")
#importexport_data
ism_data<- dbReadTable(asapadb_remote, "ism_data")
ism_s_data<- dbReadTable(asapadb_remote, "ism_s_data")
houst_data<- dbReadTable(asapadb_remote, "houst_data")
permits_data<- dbReadTable(asapadb_remote, "permits_data")
#energy_data
bmv_data<- dbReadTable(asapadb_remote, "bmv_data")
divisas_data<- dbReadTable(asapadb_remote, "divisas_data")
bmv_usd_data<- dbReadTable(asapadb_remote, "bmv_usd_data")
usa_emisoras_data<- dbReadTable(asapadb_remote, "usa_emisoras_data")
usa_emisoras_mxn_data<- dbReadTable(asapadb_remote, "usa_emisoras_mxn_data")
indices_data<- dbReadTable(asapadb_remote, "indices_data")
#emisoras
pochteca_data<- dbReadTable(asapadb_remote, "pochteca_data")
gis_data<- dbReadTable(asapadb_remote, "gis_data")
cmoctez_data<- dbReadTable(asapadb_remote, "cmoctez_data")








#source("PREPROCESSING/balanza_proc.R", local = TRUE)
#source("PREPROCESSING/igae_proc.R", local = TRUE)
#source("PREPROCESSING/igae1_proc.R", local = TRUE)

#source("PREPROCESSING/pibmex_proc.R", local = TRUE)
#source("PREPROCESSING/actind_proc.R", local = TRUE)
#source("PREPROCESSING/imai_proc.R", local = TRUE)
#source("PREPROCESSING/ifb_proc.R", local = TRUE)
#source("PREPROCESSING/ifb(desest)_proc.R", local = TRUE)
#source("PREPROCESSING/banxico_proc.R", local = TRUE)
#source("PREPROCESSING/estab_proc.R", local = TRUE)
#source("PREPROCESSING/imcp_proc.R", local = TRUE)
#source("PREPROCESSING/imcp_desest_proc.R", local = TRUE)
#source("PREPROCESSING/confianza_proc.R", local= TRUE)
#source("PREPROCESSING/inpc_mensual_proc.R", local = TRUE)
#source("PREPROCESSING/inf_mensual_proc.R", local = TRUE)
#source("PREPROCESSING/inf_mensual_interanual_proc.R", local = TRUE)
#source("PREPROCESSING/inf_anual_proc.R", local = TRUE)

#source("PREPROCESSING/inpc_q_proc.R", local = TRUE)
#source("PREPROCESSING/inf_q_proc.R", local = TRUE)
#source("PREPROCESSING/sic_proc.R", local = TRUE)
#source("PREPROCESSING/des_proc.R", local = TRUE)
#source("PREPROCESSING/construc_proc.R", local = TRUE)
#source("PREPROCESSING/automot_proc.R", local = TRUE)
#source("PREPROCESSING/USA_proc.R", local = TRUE)
#source("PREPROCESSING/analtec_proc.R", local = TRUE)
#source("PREPROCESSING/prices_proc.R", local = TRUE)

forward_mxn_swaps_data <-dbReadTable(asapadb_remote, "forward_mxn_swaps_data", check.names = FALSE)
forward_mxn_data <-dbReadTable(asapadb_remote, "forward_mxn_data", check.names = FALSE)
forward_eurmxn_swaps_data <-dbReadTable(asapadb_remote, "forward_eurmxn_swaps_data", check.names = FALSE)
forward_eurmxn_data <-dbReadTable(asapadb_remote, "forward_eurmxn_data", check.names = FALSE)
#usdswaps_data <-dbReadTable(asapadb_remote, "usdswaps", check.names = FALSE)
#usrates_data <-dbReadTable(asapadb_remote, "usrates", check.names = FALSE)
#mxbonds_data <-dbReadTable(asapadb_remote, "mxbonds", check.names = FALSE)
libor_data <-dbReadTable(asapadb_remote, "LIBORUSD_data", check.names = FALSE)
#ng_data <-dbReadTable(asapadb_remote, "ng_data", check.names = FALSE)



#metadata preproc
#source("PREPROCESSING/metadata.R", local = TRUE)

#regular (time series display) database
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
                 #gdpindex_data,
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
                 cpi_int_data,
                 #importexport_data,
                 ism_data,
                 ism_s_data,
                 houst_data,
                 permits_data,
                 #energy_data,
                 bmv_data,
                 divisas_data,
                 bmv_usd_data,
                 usa_emisoras_data,
                 usa_emisoras_mxn_data,
                 indices_data,
                 forward_mxn_swaps_data,
                 forward_mxn_data,
                 forward_eurmxn_swaps_data,
                 forward_eurmxn_data,
                 #usdswaps_data,
                 #usrates_data,
                 #mxbonds_data,
                 libor_data,
                 #ng_data,
                 pochteca_data,
                 gis_data,
                 cmoctez_data
                 )

#term structure database
termstructure_db <- list(
  forward_mxn_swaps_data,
  forward_mxn_data,
  forward_eurmxn_swaps_data,
  forward_eurmxn_data,
  #usdswaps_data,
  #usrates_data,
  #mxbonds_data,
  libor_data
)



# Init DB using credentials data
credentials <- data.frame(
  user = c("Salvador", "Felix", "Gabriel", "Graciela", "Erica", "ErnestoA", "ArturoM", "SaulC", "Johann"),
  password = c("asapa", "admin","d3G0c1YbhT", "gLbcyTUTe2", "i6dH7J3Z4d", "c1Pctiwh3b", "wJEAC0KCtM", "SHnbuokbvN", "eIlgXWzCvi"),
  # password will automatically be hashed
  admin = c(FALSE, TRUE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE, FALSE),
  stringsAsFactors = FALSE
)







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
