#igae desestacionalizado nueva implementación
igae1_data <- read.csv("DATA/igae1.csv")
rownames(igae1_data)<-igae1_data[,1]
igae1_data <- igae1_data[,-1]
names_igae1 <-c("IGAE Total",
               "IGAE Total Actividades primarias",
               "IGAE Total actividades secundarias",
               "21 Mineria",
               "22 Generacion, transmision y distribucion de energia electrica, suministro de agua y de gas por ductos al consumidor final",
               "23 Construccion",
               "31-33 Industrias manufactureras",
               "Total actividades terciarias",
               "43 Comercio al por mayor",
               "46 Comercio al por menor",
               "48-49-51 Transportes, correos y almacenamiento; Informacion en medios masivos",
               "52-53 Sevicios financieros y de seguros; Servicios inmobiliarios y de alquiler de bienes muebles e intangibles",
               "54-55-56 Servicios profesionales, cientificos y tecnicos; Corporativos; Servicios de apoyo a los negocios y manejo de desechos y servicios de remediacion",
               "61-62 Servicios educativos;Servicios de salud y de asistencia social",
               "71-81 Servicios de esparcimiento culturales y deportivos, y otros servicios recreativos; Otros servicios excepto actividades gubernamentales",
               "72 Servicios de alojamiento temporal y de preparacion de alimentos y bebidas",
               "93 Actividades legislativas, gubernamentales, de imparticion de justicia y de organismos internacionales y extraterritoriales"
)
colnames(igae1_data) <- names_igae1
rm(names_igae1)







attr(igae_data,"doc") <- "El IGAE es un indicador comprensivo de la actividad económica del país,
          que se construye de manera mensual con información preliminar y parcial,
          con el fin de anticipar el comportamiento del Producto Interno Bruto (PIB)
          nacional. Se presenta como un índice mensual que vale 100 a partir del año base
          que corresponda al PIB."

#arreglamos el formato de fecha para que R lo reconozca como año/mes
#data$Periodo <- as.yearmon(data$Periodo, format = "%Y/%m")