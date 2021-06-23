#establecimientoscomerciales
establecimientos_data <- read.csv("DATA/establecimientoscomerciales.csv")
rownames(establecimientos_data)<-establecimientos_data[,1]
establecimientos_data <- establecimientos_data[,-1]
names_establec <- c(
  "Comercio al por mayor - Indice de Personal ocupado",
  "Comercio al por mayor - Indice de Remuneraciones Reales",
  "Comercio al por mayor - Indice de Ventas",
  "Comercio al por mayor - Indice de Compras",
  "Comercio al por menor - Indice de Personal ocupado",
  "Comercio al por menor - Indice de Remuneraciones Reales",
  "Comercio al por menor - Indice de Ventas",
  "Comercio al por menor - Indice de Compras"
)
colnames(establecimientos_data) <-names_establec
rm(names_establec)