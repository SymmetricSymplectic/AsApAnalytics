#sistema de indicadores compuestos
sic_data <- read.csv("DATA/sic.csv")
rownames(sic_data)<-sic_data[,1]
sic_data <- sic_data[,-1]
names_sic <-c("Coincidente",
                "Adelantado")
colnames(sic_data) <- names_sic
rm(names_sic)