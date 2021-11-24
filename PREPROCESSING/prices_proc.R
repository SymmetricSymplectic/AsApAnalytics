library(readxl)
sheet_names <- excel_sheets("DATA/energy.xlsx")           # Get sheet names
list_all <- lapply(sheet_names, function(x) {          # Read all sheets to list
  as.data.frame(read_excel("DATA/energy.xlsx", sheet = x)) } )
names(list_all) <- sheet_names                         # Rename list elements

MyMerge <- function(x, y){
  df <- merge(x, y, by= "Date", all.x= TRUE, all.y= TRUE)
  return(df)
}


energy_data <- Reduce(MyMerge, list_all)
rm(list_all, sheet_names)
rownames(energy_data) <- energy_data[,1]
energy_data <-energy_data[,-1]


#bmv pesos

bmv_data <- read.csv("DATA/bmv.csv")
rownames(bmv_data)<-bmv_data[,1]
bmv_data <- bmv_data[,-1]

#divisas

divisas_data <- read.csv("DATA/divisas.csv")
rownames(divisas_data)<-divisas_data[,1]
divisas_data <- divisas_data[,-1]

#bmv USD

bmv_usd_data <- bmv_data/divisas_data$MXN.X

#emisoras usa

usa_emisoras_data <- read.csv("DATA/usa_emisoras.csv")
rownames(usa_emisoras_data)<-usa_emisoras_data[,1]
usa_emisoras_data <- usa_emisoras_data[,-1]

#emisoras usa en mxn

usa_emisoras_mxn_data <- usa_emisoras_data*divisas_data$MXN.X

#indices

indices_data <-read.csv("DATA/indices.csv")
rownames(indices_data) <-indices_data[,1]
indices_data <- indices_data[,-1]




