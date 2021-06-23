#inpc quincenal
inpc_q_data <- read.csv("DATA/inpc_q.csv")
#fix para fechas quincenales
fixeddates <- data.frame(inpc_q_data[,1])
k <- length(inpc_q_data[,1])-1
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
rownames(inpc_q_data)<-fixeddates[,1]
rm(fixeddates)
inpc_q_data <- inpc_q_data[,-1]
names_inpc_q <-c("Indice General",
                       "Subyacente - Total",
                       "Subyacente - Mercancias",
                       "Subcyacente - Servicios",
                       "No subyacente - Total",
                       "No subyacente - Agropecuarios",
                       "No subyacente - Energeticos y Tarifas Autorizadas")
colnames(inpc_q_data) <- names_inpc_q
rm(names_inpc_q)
