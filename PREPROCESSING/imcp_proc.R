#IMCP originales
imcp_data <- read.csv("DATA/IMCP_originales.csv")
rownames(imcp_data)<-imcp_data[,1]
imcp_data <- imcp_data[,-1]
names_imcp <-c("Total",
               "Nacional",
               "Bienes Nacionales",
               "Servicios Nacionales",
               "Bienes Importados")
colnames(imcp_data) <- names_imcp
rm(names_imcp)