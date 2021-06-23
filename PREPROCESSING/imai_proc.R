
#descargamos el archivo con las series de IMAI de la base de datos del inegi
#imai_url <- "https://www.inegi.org.mx/contenidos/temas/economia/cn/imai/tabulados/des/ivf_indice.xlsx"
#download.file(imai_url, destfile="DATA/imai.xlsx", mode='wb')

#asignamos la base descargada a un dataframe, lo transponemos para que esté en columnas las series
indice<- read_excel("DATA/imai.xlsx")
indice <- transpose(indice)
#borramos las últimas y las primeras columnas basura
indice[39:41] <- NULL
indice[1:4] <- NULL
#sacamos los nombres de las series y después los borramos del dataframe
names <- indice[2,]
indice <-indice[-c(1,2),]
#aseguramos que las columnas sean entradas numéricas
indice <- sapply(indice, as.numeric)
indice <- as.data.frame(indice)

#creamos vector de fechas de periodos para el dataframe que va a contener las observaciones 
Periodo <- seq(as.Date("1993-01-01"), as.Date(Sys.Date()), by ="months")
#creamos dataframe sacando las columnas con las observaciones y juntándolas con el vector de fechas
imai.df <- data.frame(Periodo[1:length(indice$V5)], indice)



#asignamos los nombres de las series al dataframe
colnames(imai.df) <- c("Periodo",
                       names)
#borramos todo lo innecesario
rm(indice)
rm(names)
rm(Periodo)

#arreglamos la cuenta de filas del df
row.names(imai.df) <- NULL
#arreglamos las fechas como rownames del df
imai.df$Periodo <- as.Date(imai.df$Periodo, format = "%Y-%m-%d")
rownames(imai.df) <-imai.df[,1]
imai.df <- imai.df[,-1]





#hacemos el df con las series
#data <- read_excel("igae data.xlsx")
imai_data <-imai.df
rm(imai.df)

