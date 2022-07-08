
#ifb_url <- "https://www.inegi.org.mx/contenidos/temas/economia/cn/ifb/tabulados/ori/IMIFB_1.xlsx"
#download.file(ifb_url, destfile="DATA/ifb.xlsx", mode='wb')

#datos descargados a dataframe
library(readxl)
ind <-read_excel("DATA/ifb.xlsx")
ind <- transpose(ind)
#quitamos filas basura de dato anual
trashlength <- year(Sys.Date())-1993
trashdates <-c()
trashdates[1] <- 14
for(i in 0:trashlength){
  trashdates[i+1] <- 14+13*i
}
ind[trashdates,] <- NA
rm(trashdates)
rm(trashlength)
rm(i)
#borramos las últimas y las primeras columnas basura
ind[17:23] <- NULL
ind[1:5] <- NULL
ind <- na.omit(ind)

#sacamos los nombres de las series y después los borramos del dataframe
names <- ind[1,]
ind <- ind[-1,]
#aseguramos que las columnas sean entradas numéricas
ind <- sapply(ind, as.numeric)
ind <- as.data.frame(ind)
#creamos vector de fechas de periodos para el dataframe que va a contener las observaciones 
Periodo <- seq(as.Date("1993-01-01"), as.Date(Sys.Date()), by ="1 month")
#creamos dataframe sacando las columnas con las observaciones y juntándolas con el vector de fechas
ind.df <- data.frame(Periodo[1:length(ind$V6)], ind)

#asignamos los nombres de las series al dataframe
colnames(ind.df) <- c("Periodo",
                         names)
#borramos todo lo innecesario
rm(ind)
rm(names)
rm(Periodo)
#arreglamos la cuenta de filas del df
row.names(ind.df) <- NULL
#arreglamos las fechas como rownames del df
ind.df$Periodo <- as.Date(ind.df$Periodo, format = "%Y-%m-%d")
rownames(ind.df) <-ind.df[,1]
ind.df <- ind.df[,-1]

#hacemos el df con las series
ifb_data <-ind.df
library(RMySQL)

asapadb_remote = dbConnect(MySQL(),  #remote is to be used for dbms
                           user='asapacom_Felix', 
                           password='zPySwGE4GUHQ7v9', 
                           dbname='asapacom_SisAna', 
                           host='www.asapa.com')
dbWriteTable(asapadb_remote, "ifb", ifb_data, row.names = TRUE, overwrite = TRUE )

rm(ind.df)