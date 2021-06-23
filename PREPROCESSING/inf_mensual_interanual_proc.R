#inflación mensual interanual
inf_mensual_interanual_data <- read.csv("DATA/inf_mensual_interanual.csv")
rownames(inf_mensual_interanual_data)<-inf_mensual_interanual_data[,1]
inf_mensual_interanual_data <- inf_mensual_interanual_data[,-1]
names_inf_mensual_interanual <-c("Indice General",
                      "Subyacente - Total",
                      "Subyacente - Mercancias",
                      "Subcyacente - Servicios",
                      "No subyacente - Total",
                      "No subyacente - Agropecuarios",
                      "No subyacente - Energeticos y Tarifas Autorizadas")
colnames(inf_mensual_interanual_data) <- names_inf_mensual_interanual
rm(names_inf_mensual_interanual)