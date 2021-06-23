#inflación mensual
inf_mensual_data <- read.csv("DATA/inf_mensual.csv")
rownames(inf_mensual_data)<-inf_mensual_data[,1]
inf_mensual_data <- inf_mensual_data[,-1]
names_inf_mensual <-c("Indice General",
                       "Subyacente - Total",
                       "Subyacente - Mercancias",
                       "Subcyacente - Servicios",
                       "No subyacente - Total",
                       "No subyacente - Agropecuarios",
                       "No subyacente - Energeticos y Tarifas Autorizadas")
colnames(inf_mensual_data) <- names_inf_mensual
rm(names_inf_mensual)