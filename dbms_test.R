library(RMySQL)

asapadb_remote = dbConnect(MySQL(),  #remote is to be used for dbms
                           user='felix', 
                           password='admin', 
                           dbname='SisAnaDB', 
                           host='143.198.144.181')
#asapadb_local = dbConnect(MySQL(),  #local is for locally hosted shiny and other apps
#                           user='root', 
#                           password='password', 
#                           dbname='SisAnaDB', 
#                           host='localhost')

tables <- dbListTables(asapadb_remote)


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

source("PREPROCESSING/balanza_proc.R", local = TRUE)
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



