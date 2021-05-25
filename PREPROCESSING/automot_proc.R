#vehiculos automotores
automot_data <- read.csv("DATA/automot.csv")
rownames(automot_data)<-automot_data[,1]
automot_data <- automot_data[,-1]
names_automot <-c("Produccion Total",
                   "Produccion de automoviles",
                   "Produccion de camiones",
                   "Venta de automoviles - Total",
                   "Venta de subcompactos",
                   "Venta de compactos",
                   "Venta de autos de lujo",
                   "Venta de autos deportivos",
                   "Venta de autos importados",
                  "Venta de camiones - Total",
                  "Venta de camiones Nacionales",
                  "Venta de camiones Importados")
colnames(automot_data) <- names_automot
rm(names_automot)