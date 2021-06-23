
#descargamos el archivo con las series de IMAI de la base de datos del inegi
#ifbdesest_url <- "https://www.inegi.org.mx/contenidos/temas/economia/cn/ifb/tabulados/des/ifb_indice.xlsx"
#download.file(ifbdesest_url, destfile="DATA/ifbdesest.xlsx", mode='wb')

#asignamos la base descargada a un dataframe, lo transponemos para que esté en columnas las series
indice<- read_excel("DATA/ifbdesest.xlsx")
indice <- transpose(indice)
#borramos las últimas y las primeras columnas basura
indice[17:20] <- NULL
indice[1:5] <- NULL
#sacamos los nombres de las series y después los borramos del dataframe
names <- indice[c(1,2,3),]
indice <-indice[-c(1,2,3,4),]
#aseguramos que las columnas sean entradas numéricas
indice <- sapply(indice, as.numeric)
indice <- as.data.frame(indice)

#creamos vector de fechas de periodos para el dataframe que va a contener las observaciones 
Periodo <- seq(as.Date("1993-01-01"), as.Date(Sys.Date()), by ="months")
#creamos dataframe sacando las columnas con las observaciones y juntándolas con el vector de fechas
imai.df <- data.frame(Periodo[1:length(indice$V6)], indice)



#asignamos los nombres de las series al dataframe
colnames(imai.df) <- c("Periodo",
                       names[1,1],
                       names[1,2],
                       names[2,3],
                       names[2,4],
                       names[1,5],
                       names[2,6],
                       names[3,7],
                       names[3,8],
                       names[2,9],
                       names[3,10],
                       names[3,11])
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
ifbdesest_data <-imai.df
rm(imai.df)