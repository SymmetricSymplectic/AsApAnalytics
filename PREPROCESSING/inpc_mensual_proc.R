#incp mensual
inpc_mensual_data <- read.csv("DATA/inpc_mensual.csv")
rownames(inpc_mensual_data)<-inpc_mensual_data[,1]
inpc_mensual_data <- inpc_mensual_data[,-1]
names_inpc_mensual <-c("Indice General",
               "Subyacente - Total",
               "Subyacente - Mercancias",
               "Subcyacente - Servicios",
               "No subyacente - Total",
               "No subyacente - Agropecuarios",
               "No subyacente - Energeticos y Tarifas Autorizadas")
colnames(inpc_mensual_data) <- names_inpc_mensual
rm(names_inpc_mensual)