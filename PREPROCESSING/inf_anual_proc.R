#inflación anual acumulada
inf_anual_data <- read.csv("DATA/inf_anual.csv")
rownames(inf_anual_data)<-inf_anual_data[,1]
inf_anual_data <- inf_anual_data[,-1]
names_inf_anual <-c("Indice General",
                                 "Subyacente - Total",
                                 "Subyacente - Mercancias",
                                 "Subcyacente - Servicios",
                                 "No subyacente - Total",
                                 "No subyacente - Agropecuarios",
                                 "No subyacente - Energeticos y Tarifas Autorizadas")
colnames(inf_anual_data) <- names_inf_anual
rm(names_inf_anual)