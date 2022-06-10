#actind_url <- "https://www.inegi.org.mx/contenidos/temas/economia/cn/imai/tabulados/ori/IMAI_1.xlsx"
#download.file(actind_url, destfile="DATA/actind.xlsx", mode='wb')
#datos descargados a dataframe
library(readxl)

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
colnames(actind_data) <- c("Total",                                                                                                                       
                            "21 - Mineria",                                                                                                                
                            "211 - Extracción petroleo y gas",                                                                                          
                           "212 - Mineria minerales metalicos y no metálicos",                                                 
                           "213 - Servicios relacionados mineria",                                                                                 
                           "22 - Energia electrica, suministro agua y gas por ductos",
                           "221 - Energia electrica",                                                          
                           "222 - Suministro agua y gas por ductos",                                                 
                           "23 - Construccion",                                                                                                           
                           "236 - Edificacion",                                                                                                           
                           "237 - Construccion obras ingenieria civil",                                                                             
                           "238 - Trabajos especializados construccion",                                                                          
                           "31-33 - Industrias manufactureras",                                                                                           
                           "311 - Industria alimentaria" ,                                                                                                
                           "312 - Industria bebidas y  tabaco",                                                                                 
                           "313 - Insumos textiles y acabado de textiles",                                                                 
                           "314 - Productos textiles, excepto prendas",                                                          
                           "315 - Prendas de vestir",                                                                                      
                           "316 - Cuero y piel",                  
                           "321 - Industria madera",                                                                                                
                           "322 - Industria papel",                                                                                                   
                           "323 - Impresion",                                                                                        
                           "324 - Derivados petróleo y carbon",                                                          
                           "325 - Industria quimica",                                                                                                     
                           "326 - Industria del plastico y hule",                                                                                     
                           "327 - Productos a base de minerales no metalicos",                                                             
                           "331 - Industrias metalicas basicas",                                                                                          
                           "332 - Productos metálicos",                                                                                    
                           "333 - Maquinaria y equipo",                                                                                    
                           "334 - Computación y accesorios electrónicos",
                           "335 - Equipo de generacion de energia electrica",                            
                           "336 - Equipo de transporte",                                                                                   
                           "337 - Muebles, colchones y persianas",                                                                         
                           "339 - Otras industrias" )

rm(actind.df)
dbWriteTable(asapadb_remote, "actind", actind_data, row.names = TRUE, overwrite = TRUE )






