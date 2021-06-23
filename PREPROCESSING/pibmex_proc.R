#nueva implementación con la api
pibmex_data <- read.csv("DATA/pibmex.csv")
rownames(pibmex_data)<-pibmex_data[,1]
pibmex_data <- pibmex_data[,-1]
names_pibmex <-c("Producto Interno Bruto, a precios de mercado",
                   "Impuestos a los productos, netos",
                   "Valor agregado bruto a precios basicos",
                   "11 Agricultura, cria y explotacion de animales, aprovechamiento forestal, pesca y caza",
                   "Total actividades secundarias",
                   "21 Mineria",
                   "22 Generación, transmisión y distribución de energía electrica, suministro de agua y de gas por ductos al consumidor final",
                   "23 Construccion",
                   "31-33 Industrias manufactureras",
                 "Total actividades terciarias",
                 "43 Comercio al por mayor",
                 "46 Comercio al por menor",
                 "48-49 Transportes, correos y almacenamiento",
                 "51 Información en medios masivos",
                 "52 Sevicios financieros y de seguros",
                 "53 Servicios inmobiliarios y de alquiler de bienes muebles e intangibles",
                 "54 Servicios profesionales, cientificos y tecnicos",
                 "55 Corporativos",
                 "56 Servicios de apoyo a los negocios y manejo de desechos y servicios de remediacion",
                 "61 Servicios educativos",
                 "62 Servicios de salud y de asistencia social",
                 "71 Servicios de esparcimiento culturales y deportivos, y otros servicios recreativos",
                 "72 Servicios de alojamiento temporal y de preparacion de alimentos y bebidas",
                 "81 Otros servicios excepto actividades gubernamentales",
                 "93 Actividades legislativas, gubernamentales, de imparticion de justicia y de organismos internacionales y extraterritoriales"
                 )
colnames(pibmex_data) <- names_pibmex
rm(names_pibmex)

attr(pibmex_data,"doc") <- ""
