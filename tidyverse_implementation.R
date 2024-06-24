#this file is for testing tidyverse implementation of current functions for ver2.0 of app
library(RMySQL)
asapadb_remote = dbConnect(MySQL(),  #remote is to be used for dbms
                           user='Felix', 
                           password='XkxY1BgiwXFpTWvF', 
                           dbname='SisAna', 
                           host='146.190.57.35',
                           port = as.numeric("3306"))



tablelist <- dbReadTable(asapadb_remote, "tablelist")
rateslist <- filter(tablelist, rate == 1)
rateslist$index <- rownames(rateslist)

#initial db load call
database <-list()
for (i in 1:length(tablelist$index)){
  table <- dbReadTable(conn=asapadb_remote, name=paste(tablelist$dbname[i]))
  assign(paste(tablelist$dfname[i]), table )
  database[[i]] <-get(tablelist$dfname[i])
  rm(list=paste(tablelist$dfname[i]))
  rm(table)
}

termstructure_db <- list()
for (i in 1:length(rateslist$index)){
  table <- dbReadTable(conn=asapadb_remote, name=paste(rateslist$dbname[i]))
  assign(paste(rateslist$dfname[i]), table )
  termstructure_db[[i]] <-get(rateslist$dfname[i])
  rm(list=paste(rateslist$dfname[i]))
  rm(table)
}
#create named vectors for shiny selectizer
rate_choices <- rateslist$index
names(rate_choices) <-rateslist$tablename

ind_choices <- tablelist$index
names(ind_choices) <-tablelist$tablename









#test dataframes
df1 <- retail_data
libor_data <-dbReadTable(asapadb_remote, "LIBORUSD_data", check.names = FALSE)
autos_data<- dbReadTable(asapadb_remote, "autos_data")

#old graphics implementation
data <- autos_data

data <- data[order(as.Date(rownames(data), format="%d/%m/%Y")),]

selseries <- na.omit(data)
library(TSstudio)
library(xts)
library(dplyr)
library(plotly)
don <- xts(x = selseries, order.by = as.Date(rownames(selseries)))
ts_plot(don)


#test global transform functions
library(tidyverse)
library(fable)
selnames <- colnames(df1)

df1%>%
  rownames_to_column(var = "Fecha")%>%
  mutate(Fecha = ymd(Fecha))%>%
  as_tsibble()%>%
  autoplot()



# tidyverse function for setting initial common period as base period: 
baseperiod_function_tidy <- function(x, inputdate){
  # input: x dataframe
  # output: x indexed dataframe
  #x <-x[paste(inputdate, "/", sep = "")] if one wants inputdate to be starting year 
  x_indexed <- apply(na.omit(x), 2, function(v) 100*v/v[paste(inputdate)])
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


