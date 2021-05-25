#inflacion quincenal
inf_q_data <- read.csv("DATA/inf_q.csv")
#fix para fechas quincenales
fixeddates <- data.frame(inf_q_data[,1])
k <- length(inf_q_data[,1])-1
for (i in 1:k){
  if(fixeddates[i,1]==fixeddates[i+1,1] ){
    fixeddates[i,1] <- as.character(ymd(fixeddates[i,1])+14)
  }
  else{
    fixeddates[i,1] <- as.character(ymd(fixeddates[i,1]))
  }
}
rm(k)
rm(i)
rownames(inf_q_data)<-fixeddates[,1]
rm(fixeddates)
inf_q_data <- inf_q_data[,-1]
names_inf_q <-c("Indice General",
                 "Subyacente - Total",
                 "Subyacente - Mercancias",
                 "Subcyacente - Servicios",
                 "No subyacente - Total",
                 "No subyacente - Agropecuarios",
                 "No subyacente - Energeticos y Tarifas Autorizadas")
colnames(inf_q_data) <- names_inf_q
rm(names_inf_q)