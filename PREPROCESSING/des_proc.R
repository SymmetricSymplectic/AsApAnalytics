#tasa de desocupación
des_data <- read.csv("DATA/des.csv")
rownames(des_data)<-des_data[,1]
des_data <- des_data[,-1]
names_des <-c("Total",
              "Hombres",
              "Mujeres")
colnames(des_data) <- names_des
rm(names_des)