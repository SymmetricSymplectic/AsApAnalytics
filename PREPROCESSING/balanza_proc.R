#balanza comercial
balanza_data <-read.csv("DATA/balanza_com.csv")
rownames(balanza_data)<-balanza_data[,1]
balanza_data <- balanza_data[,-1]
names_balanza <- c("Exportaciones totales FOB",
                   "Importaciones totales FOB",
                   "Exportaciones B. de Consumo",
                   "Importaciones B. de Consumo",
                   "Export. B. de uso intermedio",
                   "Import. B. de uso intermedio",
                   "Export. B. de Capital",
                   "Import. B. de Capital")
colnames(balanza_data) <-names_balanza
rm(names_balanza)