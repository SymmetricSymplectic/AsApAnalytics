
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
colnames(imai_data) <- c("Total",                                                                                                                       
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
dbWriteTable(asapadb_remote, "imai", imai_data, row.names = TRUE, overwrite = TRUE )

