#confianza del consumidor
confianza_data <- read.csv("DATA/confianza.csv")
rownames(confianza_data)<-confianza_data[,1]
confianza_data <- confianza_data[,-1]
names_confianza <-c("Original",
               "Desestacionalizada")
colnames(confianza_data) <- names_confianza
rm(names_confianza)