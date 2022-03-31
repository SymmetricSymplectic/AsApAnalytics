#igae nueva implementación
igae_data <- read.csv("DATA/igae.csv")
rownames(igae_data)<-igae_data[,1]
igae_data <- igae_data[,-1]
names_igae <-c("IGAE Total",
                 "IGAE Total Actividades primarias",
                 "IGAE Total actividades secundarias",
                 "21 Mineria",
                 "22 Gen, trans y distrib de energia electrica, agua y gas",
                 "23 Construccion",
                 "31-33 Industrias manufactureras",
                 "Total actividades terciarias",
                 "43 Comercio al por mayor",
                 "46 Comercio al por menor",
                 "48-49-51 Transportes, correos y almacenamiento",
                 "52-53 Sevicios financieros y de seguros; inmobiliarios",
                 "54-55-56 Servicios profesionales",
                 "61-62 Servicios educativos;salud, asistencia social",
                 "71-81 Servicios de esparcimiento cultural y deportivo",
                 "72 Servicios de alojamiento temporal",
                 "93 Actividades legislativas, gubernamentales"
)
colnames(igae_data) <- names_igae
rm(names_igae)

dbWriteTable(asapadb_remote, "igae", igae_data, row.names = TRUE, append = TRUE ) 






attr(igae_data,"doc") <- "El IGAE es un indicador comprensivo de la actividad económica del país,
          que se construye de manera mensual con información preliminar y parcial,
          con el fin de anticipar el comportamiento del Producto Interno Bruto (PIB)
          nacional. Se presenta como un índice mensual que vale 100 a partir del año base
          que corresponda al PIB."

#arreglamos el formato de fecha para que R lo reconozca como año/mes
#data$Periodo <- as.yearmon(data$Periodo, format = "%Y/%m")
