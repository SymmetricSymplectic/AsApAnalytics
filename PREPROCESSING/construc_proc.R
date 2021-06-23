#valor de la construccion
construc_data <- read.csv("DATA/construc.csv")
rownames(construc_data)<-construc_data[,1]
construc_data <- construc_data[,-1]
names_construc <-c(#"Fecha",
  "Total",
              "Sector Publico",
              "Sector Privado",
              "Edificacion",
              "Agua, riego y saneamiento",
              "Electricidad y telecomunicaciones",
              "Transporte y urbanizacion",
              "Petroleo y petroquimica",
              "Otras construcciones")
colnames(construc_data) <- names_construc
rm(names_construc)