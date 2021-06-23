#actind_url <- "https://www.inegi.org.mx/contenidos/temas/economia/cn/imai/tabulados/ori/IMAI_1.xlsx"
#download.file(actind_url, destfile="DATA/actind.xlsx", mode='wb')
#datos descargados a dataframe
actind_ind <-read_excel("DATA/actind.xlsx")
transpose <- data.table::transpose
actind_ind <- data.table::transpose(actind_ind)
#quitamos filas basura de dato anual
trashlength <- year(Sys.Date())-1993
trashdates <-c()
trashdates[1] <- 14
for(i in 0:trashlength){
  trashdates[i+1] <- 14+13*i
}
actind_ind[trashdates,] <- NA
rm(trashdates)
rm(trashlength)
rm(i)
#borramos las últimas y las primeras columnas basura
actind_ind[40:46] <- NULL
actind_ind[1:5] <- NULL
actind_ind <- na.omit(actind_ind)

#sacamos los nombres de las series y después los borramos del dataframe
names_actind <- actind_ind[1,]
actind_ind <- actind_ind[-1,]
#aseguramos que las columnas sean entradas numéricas
actind_ind <- sapply(actind_ind, as.numeric)
actind_ind <- as.data.frame(actind_ind)
#creamos vector de fechas de periodos para el dataframe que va a contener las observaciones 
Periodo <- seq(as.Date("1993-01-01"), as.Date(Sys.Date()), by ="1 month")
#creamos dataframe sacando las columnas con las observaciones y juntándolas con el vector de fechas
actind.df <- data.frame(Periodo[1:length(actind_ind$V6)], actind_ind)

#asignamos los nombres de las series al dataframe
colnames(actind.df) <- c("Periodo",
                         names_actind)
#borramos todo lo innecesario
rm(actind_ind)
rm(names_actind)
rm(Periodo)
#arreglamos la cuenta de filas del df
row.names(actind.df) <- NULL
#arreglamos las fechas como rownames del df
actind.df$Periodo <- as.Date(actind.df$Periodo, format = "%Y-%m-%d")
rownames(actind.df) <-actind.df[,1]
actind.df <- actind.df[,-1]

#hacemos el df con las series
actind_data <-actind.df
rm(actind.df)







