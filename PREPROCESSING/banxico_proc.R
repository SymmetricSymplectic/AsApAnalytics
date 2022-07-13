#Preparación de datos: reservas internacionales de Banxico (millones de dólares) (mensual)
reservas_data <- read.csv("DATA/reservas.csv")
rownames(reservas_data) <- reservas_data[,1]
reservas_data[,c(1,3)] <- NULL
colnames(reservas_data) <- c("Reserva Internacional (mdd de E.U.)","Otros activos en moneda extranjera (mdd de E.U.)")
reservas_data <- na.omit(reservas_data)

#reservas internacionales (millones de dolares) (semanal)
reservas_semanales_data <- read.csv("DATA/reservas_semanales.csv")
rownames(reservas_semanales_data) <- reservas_semanales_data[,1]
reservas_semanales_data[,1] <- NULL
colnames(reservas_semanales_data) <- "Reserva Internacional (mdd de E.U.)"
reservas_semanales_data <- na.omit(reservas_semanales_data)

#remesas familiares
remesas_fam_data <- read.csv("DATA/remesas_fam.csv")
rownames(remesas_fam_data) <- remesas_fam_data[,1]
remesas_fam_data[,1] <- NULL
colnames(remesas_fam_data) <- "Remesas Familiares (mdd de E.U.)"
remesas_fam_data <- na.omit(remesas_fam_data)


 

