#inegi downloader function
library(httr)
library(jsonlite)
library(rjson)
library(readr)
library(dplyr)
library(inegiR)

token_inegi <- "e6198ee1-4481-4c00-835c-920d299e0204"

#actind
series <- c(496326,496327,496328,496329,496330,496331,496332,496333,496334,496335,
            496336,496337,496338,496339,496340,496341,496342,496343,496344,496345,
            496346,496347,496348,496349,496350,496351,496352,496353,496354,496355,
            496356,496357,496358,496359)
names <- c("Total",
           "21 - Mineria",
           "211 - Extracción de petróleo y gas",
           "212 - Minería de minerales, excepto petroleo y gas",
           "213 - Servicios relacionados con la minería",
           "22 - Energía eléctrica, suministro de agua y de gas",
           "221 - Generación energía eléctrica",
           "222 - Suministro de agua y suministro de gas por ductos",
           "23 - Construcción",
           "236 - Edificación",
           "237 - Construcción de obras de ingenieria civil",
           "238 - Trabajos especializados para la construccion",
           "31-33 - Industrias manufactureras",
           "311 - Industria alimentaria",
           "312 - Industria de las bebidas y del tabaco",
           "313 - Insumos textiles y acabado de textiles",
           "314 - Productos textiles, excepto prendas",
           "315 - Fabricación de prendas de vestir",
           "316 - Curtido y acabado de cuero y piel",
           "321 - Industria de la madera",
           "322 - Industria del papel",
           "323 - Impresión e industrias conexas",
           "324 - Derivados del petroleo y carbon",
           "325 - Industria química",
           "326 - Industria del plástico y del hule",
           "327 - Fabricación de productos a base de minerales no metálicos",
           "331 - Industrias metalicas basicas",
           "332 - Fabricacinn de productos metalicos",
           "333 - Fabricacion de maquinaria y equipo",
           "334 - Fabricacion de equipo de computación, comunicación, medición y de otros equipos, componentes y accesorios electrónicos",
           "335 - Accesorios y equipo de generación de energía eléctrica",
           "336 - Equipo de transporte",
           "337 - Muebles, colchones y persianas",
           "339 - Otras industrias manufactureras")

downloader_inegi <-function(series, names){
  
}

data <- lapply(series, inegi_series, token_inegi)
unlisted <- data.frame(lapply(data, '[',3))
names(unlisted) <- names
write.csv(data, "DATA/actind.csv")
rm(series, names)