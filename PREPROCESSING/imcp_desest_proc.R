#IMCP desestacionalizadas
imcp_desest_data <- read.csv("DATA/IMCP_desest.csv")
rownames(imcp_desest_data)<-imcp_desest_data[,1]
imcp_desest_data <- imcp_desest_data[,-1]
names_imcp <-c("Total",
               "Nacional",
               "Bienes Nacionales",
               "Servicios Nacionales",
               "Bienes Importados")
colnames(imcp_desest_data) <- names_imcp
rm(names_imcp)