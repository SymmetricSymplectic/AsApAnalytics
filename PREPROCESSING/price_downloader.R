#yfinance data source
library(RMySQL)

asapadb_remote = dbConnect(MySQL(),  #remote is to be used for dbms
                           user='asapacom_Felix', 
                           password='zPySwGE4GUHQ7v9', 
                           dbname='asapacom_SisAna', 
                           host='www.asapa.com')

library(rusquant)
library(tidyr)

usdswaps <- c("USDSB3L1Y=",
              "USDSB3L2Y=",
              "USDSB3L3Y=",
              "USDSB3L4Y=",
              "USDSB3L5Y=",
              "USDSB3L6Y=",
              "USDSB3L7Y=",
              "USDSB3L8Y=",
              "USDSB3L10Y=",
              "USDSB3L30Y=")

stocks<-lapply(usdswaps, function(symbol) {
  aStock<-as.data.frame(getSymbols(symbol,return.class="zoo",auto.assign = FALSE,
                                   src = "Investing"
  ))
  colnames(aStock) <- c("Open","High","Low","Close")
  aStock$Symbol<-symbol
  aStock$Date <- as.Date(rownames(aStock),"%Y-%m-%d")
  aStock[-1,]
})
stocksDf <- do.call(rbind,stocks)
rm(stocks,aStock)
df <- stocksDf %>% dplyr::select(Date,Close,Symbol) %>% 
  pivot_wider(names_from = Symbol,values_from=Close,values_fn = mean)
df <- data.frame(df)
write.csv(df, file = "DATA/usdswaps.csv", row.names = FALSE)

usdswaps_data <-read.csv("DATA/usdswaps.csv")
rownames(usdswaps_data) <-usdswaps_data[,1]
usdswaps_data <- usdswaps_data[,-1]
dbWriteTable(asapadb_remote, "usdswaps", usdswaps_data, row.names = TRUE, append = TRUE ) 

              
              
              









bmv <-c("WALMEX.MX",
        "GFNORTEO.MX",
        "AMXL.MX",
        "GMEXICOB.MX",
        "FEMSAUBD.MX",
        "GRUMAB.MX",
        "CEMEXCPO.MX",
        "KIMBERA.MX",
        "GAPB.MX",
        "FUNO11.MX",
        #"IENOVA.MX",
        "AC.MX",
        "BIMBOA.MX",
        "OMAB.MX",
        "ASURB.MX",
        "ALFAA.MX",
        "ORBIA.MX",
        "PINFRA.MX",
        "GFINBURO.MX",
        "GCC.MX",
        "GCARSOA1.MX",
        "BOLSAA.MX",
        #"ELEKTRA.MX",
        "RA.MX",
        "VOLARA.MX",
        "NEMAKA.MX",
        "CUERVO.MX",
        "ALPEKA.MX",
        "ALSEA.MX",
        "GAPB.MX",
        "DANHOS13.MX",
        "FIBRAMQ12.MX",
        "CERAMICB.MX",
        "LAMOSA.MX",
        "KUOB.MX",
        #"PE&OLES.MX",
        "KOFUBL.MX",
        "GISSAA.MX",
        "CMOCTEZ.MX")



stocks<-lapply(bmv, function(symbol) {
  aStock<-as.data.frame(getSymbols(symbol,return.class="zoo",auto.assign = FALSE
                                   ))
  colnames(aStock) <- c("Open","High","Low","Close","Volume","Adjusted")
  aStock$Symbol<-symbol
  aStock$LogRet<- c(NA,diff(log(aStock$Adjusted)))
  aStock$Date <- as.Date(rownames(aStock),"%Y-%m-%d")
  aStock[-1,]
})
stocksDf <- do.call(rbind,stocks)
rm(stocks,aStock)
bmv <- stocksDf %>% dplyr::select(Date,Close,Symbol) %>% 
  pivot_wider(names_from = Symbol,values_from=Close,values_fn = mean)
bmv <- data.frame(bmv)
write.csv(bmv, file = "DATA/bmv.csv", row.names = FALSE)

#divisas

divisas <-c("ARS=X",
            "EURUSD=X",
            "GBPUSD=X",
            "JPY=X",
            "CAD=X",
            "CHF=X",
            "SEK=X",
            "CZK=X",
            "PLN=X",
            "CNY=X",
            "KRW=X",
            "INR=X",
            "BRL=X",
            "CLP=X",
            "RUB=X",
            "TRY=X",
            "MXN=X",
            "EURMXN=X")


stocks<-lapply(divisas, function(symbol) {
  aStock<-as.data.frame(getSymbols(symbol,return.class="zoo",auto.assign = FALSE
  ))
  colnames(aStock) <- c("Open","High","Low","Close","Volume","Adjusted")
  aStock$Symbol<-symbol
  aStock$LogRet<- c(NA,diff(log(aStock$Adjusted)))
  aStock$Date <- as.Date(rownames(aStock),"%Y-%m-%d")
  aStock[-1,]
})
stocksDf <- do.call(rbind,stocks)
rm(stocks,aStock)
divisas <- stocksDf %>% dplyr::select(Date,Close,Symbol) %>% 
  pivot_wider(names_from = Symbol,values_from=Close,values_fn = mean)
divisas <- data.frame(divisas)
write.csv(divisas, file = "DATA/divisas.csv", row.names = FALSE)

#indices
indices <-c("^IXIC",
            "^NDX",
            "^DJI",
            "^GSPC",
            "^MXX",
            "^VIX",
            "000001.SS",
            "^HSI",
            "^N225",
            "^KS11",
            "^BSESN",
            "^GDAXI",
            "^FCHI",
            "^FTSE",
            "^IBEX",
            "^STOXX50E",
            "^STOXX",
            "^TNX",
            "^TYX",
            "DX-Y.NYB",
            "^CMC200")


stocks<-lapply(indices, function(symbol) {
  aStock<-as.data.frame(getSymbols(symbol,return.class="zoo",auto.assign = FALSE
  ))
  colnames(aStock) <- c("Open","High","Low","Close","Volume","Adjusted")
  aStock$Symbol<-symbol
  aStock$LogRet<- c(NA,diff(log(aStock$Adjusted)))
  aStock$Date <- as.Date(rownames(aStock),"%Y-%m-%d")
  aStock[-1,]
})
stocksDf <- do.call(rbind,stocks)
rm(stocks,aStock)
indices <- stocksDf %>% dplyr::select(Date,Close,Symbol) %>% 
  pivot_wider(names_from = Symbol,values_from=Close,values_fn = mean)
indices <- data.frame(indices)
write.csv(indices, file = "DATA/indices.csv", row.names = FALSE)


#emisoras usa
usa <- c("MSFT",
         "AAPL",
         "AMZN",
         "TSLA",
         "NVDA",
         "GOOG",
         "FB",
         "ADBE",
         "NFLX",
         "PYPL",
         #"CMCSA",
         "CSCO",
         "INTC",
         "AMD",
         "PEP",
         "QCOM",
         "V",
         "GS",
         "CRM"
)

stocks<-lapply(usa, function(symbol) {
  aStock<-as.data.frame(getSymbols(symbol,return.class="zoo",auto.assign = FALSE
  ))
  colnames(aStock) <- c("Open","High","Low","Close","Volume","Adjusted")
  aStock$Symbol<-symbol
  aStock$LogRet<- c(NA,diff(log(aStock$Adjusted)))
  aStock$Date <- as.Date(rownames(aStock),"%Y-%m-%d")
  aStock[-1,]
})
stocksDf <- do.call(rbind,stocks)
rm(stocks,aStock)
usa <- stocksDf %>% dplyr::select(Date,Close,Symbol) %>% 
  pivot_wider(names_from = Symbol,values_from=Close,values_fn = mean)
usa <- data.frame(usa)
write.csv(usa, file = "DATA/usa_emisoras.csv", row.names = FALSE)



rm(stocksDf, bmv, divisas,indices, usa)








