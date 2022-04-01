#Preparación de datos: reservas internacionales de Banxico (millones de dólares) (mensual)
reservas_data <- read.csv("DATA/reservas.csv")
rownames(reservas_data) <- reservas_data[,1]
reservas_data[,1] <- NULL
colnames(reservas_data) <- "Reserva Internacional (mdd de E.U.)"
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


#tasas forwards mxn de swaps
#forward_mxn_swaps_data <- read.csv("DATA/forward_mxn_swaps.csv")
#rownames(forward_mxn_swaps_data) <- forward_mxn_swaps_data[,1]
#forward_mxn_swaps_data[,1] <- NULL
#colnames(forward_mxn_swaps_data) <- c("1-7d", "8-30d", "31-60d",
#                                      "61-90d", "91-120d", "121-150d",
#                                      "151-180d", "181-210d", "211-240d",
#                                      "241-270d", "271-300d", "301-330d",
#                                      "331-360d", "361-731d", "732-1096d",
#                                      "1097-1461d", "1462-1827d", "1828-2557d",
#                                      "2558-3653d", "3654-5479d", "5480-7305d",
#                                      "Over 7306d")
#forward_mxn_swaps_data <- na.omit(forward_mxn_swaps_data)
#dbWriteTable(asapadb_remote, "forward_mxn_swaps", forward_mxn_swaps_data, row.names = TRUE, append = TRUE ) 

