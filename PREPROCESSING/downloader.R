library(RMySQL)

asapadb_remote = dbConnect(MySQL(),  #remote is to be used for dbms
                           user='asapacom_Felix', 
                           password='zPySwGE4GUHQ7v9', 
                           dbname='asapacom_SisAna', 
                           host='www.asapa.com')




#the downloader
#actividad industrial
#actind_url <- "https://www.inegi.org.mx/contenidos/temas/economia/cn/imai/tabulados/ori/IMAI_1.xlsx"
#download.file(actind_url, destfile="DATA/actind.xlsx", mode='wb')
#inversion fija buta
ifbdesest_url <- "https://www.inegi.org.mx/contenidos/temas/economia/cn/ifb/tabulados/des/ifb_indice.xlsx"
download.file(ifbdesest_url, destfile="DATA/ifbdesest.xlsx", mode='wb')
ifb_url <- "https://www.inegi.org.mx/contenidos/temas/economia/cn/ifb/tabulados/ori/IMIFB_1.xlsx"
download.file(ifb_url, destfile="DATA/ifb.xlsx", mode='wb')
#descargamos el archivo con las series de IGAE de la base de datos del inegi
#igae1_url <- "https://www.inegi.org.mx/contenidos/temas/economia/cn/igae/tabulados/ori/IGAE_1.xlsx"
#download.file(igae1_url, destfile="DATA/igae1_ind.xlsx", mode='wb')
#igae_url <- "https://www.inegi.org.mx/contenidos/temas/economia/cn/igae/tabulados/des/igae_indice.xlsx"
#download.file(igae_url, destfile="DATA/igae_ind.xlsx", mode='wb')
#descargamos el archivo con las series de IMAI de la base de datos del inegi
imai_url <- "https://www.inegi.org.mx/contenidos/temas/economia/cn/imai/tabulados/des/ivf_indice.xlsx"
download.file(imai_url, destfile="DATA/imai.xlsx", mode='wb')
#descargamos archivo del pib en inegi
#pibmex_url <- "https://www.inegi.org.mx/contenidos/temas/economia/pib/pibt/tabulados/ori/PIBT_2.xlsx"
#download.file(pibmex_url, destfile="DATA/pibmex.xlsx", mode='wb')


library(httr)
library(jsonlite)
library(rjson)
library(readr)
library(dplyr)
library(inegiR)

token_inegi <- "e6198ee1-4481-4c00-835c-920d299e0204"

#actind



#balanza comercial
library(inegiR)
bal_exp_tot <- inegi_series("33860", token_inegi)
bal_imp_tot <- inegi_series("33861", token_inegi)
exp_b_cons <- inegi_series("33862", token_inegi)
imp_b_cons <- inegi_series("33863", token_inegi)
exp_b_uso <- inegi_series("33864", token_inegi)
imp_b_uso <- inegi_series("33865", token_inegi)
exp_b_cap <- inegi_series("33866", token_inegi)
imp_b_cap <- inegi_series("33867", token_inegi)
s1 <- inegi_series("897", token_inegi)
s2 <- inegi_series("375922", token_inegi)
s3 <- inegi_series("206784", token_inegi)
s4 <- inegi_series("206785", token_inegi)
sq <- seq(max(length(bal_exp_tot$date), length(exp_b_cap$date)))
balanza <- data.frame(bal_exp_tot$date[sq], 
                      bal_exp_tot$values[sq],
                      bal_imp_tot$values[sq],
                      exp_b_cons$values[sq],
                      imp_b_cons$values[sq],
                      exp_b_uso$values[sq],
                      imp_b_uso$values[sq],
                      exp_b_cap$values[sq],
                      imp_b_cap$values[sq],
                      s1$values[sq],
                      s2$values[sq],
                      s3$values[sq],
                      s4$values[sq]
                      )

rm(bal_exp_tot,bal_imp_tot,exp_b_cons,imp_b_cons,exp_b_uso,
   imp_b_uso,exp_b_cap,imp_b_cap, s1,s2,s3,s4,sq)
write.csv(balanza, "DATA/balanza_com.csv", row.names = FALSE)
rm(balanza)
balanza_data <-read.csv("DATA/balanza_com.csv")
rownames(balanza_data)<-balanza_data[,1]
balanza_data <- balanza_data[,-1]
names_balanza <- c("Exportaciones totales FOB",
                   "Importaciones totales FOB",
                   "Exportaciones B. de Consumo",
                   "Importaciones B. de Consumo",
                   "Export. B. de uso intermedio",
                   "Import. B. de uso intermedio",
                   "Export. B. de Capital",
                   "Import. B. de Capital",
                   "Saldo Total",
                   "Saldo sin exportaciones petroleras",
                   "Saldo productos petroleros",
                   "Saldo productos no petroleros")
colnames(balanza_data) <-names_balanza
rm(names_balanza)
dbWriteTable(asapadb_remote, "balanza_comercial", balanza_data, row.names = TRUE, overwrite = TRUE )


#establecimientos comerciales
mayoreo_ocup <- inegi_series("654033", token_inegi)
mayoreo_remun <- inegi_series("654040", token_inegi)
mayoreo_ventas <- inegi_series("654047", token_inegi)
mayoreo_compras <- inegi_series("654432", token_inegi)
menudeo_ocup <- inegi_series("654439", token_inegi)
menudeo_remun <- inegi_series("654446", token_inegi)
menudeo_ventas <- inegi_series("654453", token_inegi)
menudeo_compras <- inegi_series("654880", token_inegi)
comerciales <- data.frame(mayoreo_ocup$date,
                          mayoreo_ocup$values,
                          mayoreo_remun$values, 
                          mayoreo_ventas$values,
                          mayoreo_compras$values,
                          menudeo_ocup$values,
                          menudeo_remun$values,
                          menudeo_ventas$values,
                          menudeo_compras$values
                          )
rm(mayoreo_ocup, 
   mayoreo_remun, 
   mayoreo_ventas,
   mayoreo_compras,
   menudeo_ocup,
   menudeo_remun,
   menudeo_ventas,
   menudeo_compras )
write.csv(comerciales, "DATA/establecimientoscomerciales.csv", row.names = FALSE)
rm(comerciales)

#indicador mensual consumo privado interior (original)
imcp_total <- inegi_series("497613", token_inegi)
imcp_nacional <- inegi_series("509979", token_inegi)
imcp_nacional_bienes <- inegi_series("509980", token_inegi)
imcp_nacional_servicios <- inegi_series("509981", token_inegi)
imcp_importado <- inegi_series("509982", token_inegi)
imcp_original <-data.frame(imcp_total$date,
                           imcp_total$values,
                           imcp_nacional$values,
                           imcp_nacional_bienes$values,
                           imcp_nacional_servicios$values,
                           imcp_importado$values)
rm(imcp_total,
   imcp_nacional,
   imcp_nacional_bienes,
   imcp_nacional_servicios,
   imcp_importado)
write.csv(imcp_original, "DATA/IMCP_originales.csv", row.names = FALSE)
rm(imcp_original)

#indicador mensual consumo privado interior (desest)
imcp_total_desest <- inegi_series("497635", token_inegi)
imcp_nacional_desest <- inegi_series("497642", token_inegi)
imcp_nacional_bienes_desest <- inegi_series("497649", token_inegi)
imcp_nacional_servicios_desest <- inegi_series("497656", token_inegi)
imcp_importado_desest <- inegi_series("497663", token_inegi)
imcp_desest <-data.frame(imcp_total_desest$date,
                           imcp_total_desest$values,
                           imcp_nacional_desest$values,
                           imcp_nacional_bienes_desest$values,
                           imcp_nacional_servicios_desest$values,
                           imcp_importado_desest$values)
rm(imcp_total_desest,
   imcp_nacional_desest,
   imcp_nacional_bienes_desest,
   imcp_nacional_servicios_desest,
   imcp_importado_desest)
write.csv(imcp_desest, "DATA/IMCP_desest.csv", row.names = FALSE)
rm(imcp_desest)

#confianza del consumidor
confianza <-inegi_series("454168", token_inegi)
confianza_desest <- inegi_series("454186", token_inegi)
confianzas <- data.frame(confianza$date,
                        confianza$values,
                        confianza_desest$values)
rm(confianza, confianza_desest)
write.csv(confianzas, "DATA/confianza.csv", row.names = FALSE)
rm(confianzas)

#indice de precios al consumidor mensual
#628194,628195,628196,628197,628198,628199,628200
inpcgeneral <-inegi_series("628194", token_inegi)
inpcsub_total <-inegi_series("628195", token_inegi)
inpcmerc <-inegi_series("628196", token_inegi) 
inpcserv <-inegi_series("628197", token_inegi)
inpcnosub <-inegi_series("628198", token_inegi)
inpcagro <-inegi_series("628199", token_inegi)
inpcenerg <-inegi_series("628200", token_inegi)
#truco para juntar vectores de longitud diferente en el mismo df y usar las fechas del más largo
sq <- seq(max(length(inpcgeneral$date), length(inpcsub_total$date)))

inpc_mensual <- data.frame(inpcgeneral$date[sq],
                           inpcgeneral$values[sq],
                           inpcsub_total$values[sq],
                           inpcmerc$values[sq], 
                           inpcserv$values[sq],
                           inpcnosub$values[sq],
                           inpcagro$values[sq],
                           inpcenerg$values[sq])
rm(inpcgeneral, 
   inpcsub_total, 
   inpcmerc,
   inpcserv, 
   inpcnosub,
   inpcagro,
   inpcenerg)
write.csv(inpc_mensual, "DATA/inpc_mensual.csv", row.names = FALSE)
rm(inpc_mensual)


#inflación mensual
#628201,628202,628203,628204,628205,628206,628207
infgeneral <-inegi_series("628201", token_inegi)
infsub_total <-inegi_series("628202", token_inegi)
infmerc <-inegi_series("628203", token_inegi) 
infserv <-inegi_series("628204", token_inegi)
infnosub <-inegi_series("628205", token_inegi)
infagro <-inegi_series("628206", token_inegi)
infenerg <-inegi_series("628207", token_inegi)
#truco para juntar vectores de longitud diferente en el mismo df y usar las fechas del más largo
sq <- seq(max(length(infgeneral$date), length(infsub_total$date)))

inf_mensual <- data.frame(infgeneral$date[sq],
                           infgeneral$values[sq],
                           infsub_total$values[sq],
                           infmerc$values[sq], 
                           infserv$values[sq],
                           infnosub$values[sq],
                           infagro$values[sq],
                           infenerg$values[sq])
rm(infgeneral, 
   infsub_total, 
   infmerc,
   infserv, 
   infnosub,
   infagro,
   infenerg)
write.csv(inf_mensual, "DATA/inf_mensual.csv", row.names = FALSE)
rm(inf_mensual)

#inflación mensual interanual
#628208,628209,628210,628211,628212,628213,628214
infgeneral <-inegi_series("628208", token_inegi)
infsub_total <-inegi_series("628209", token_inegi)
infmerc <-inegi_series("628210", token_inegi) 
infserv <-inegi_series("628211", token_inegi)
infnosub <-inegi_series("628212", token_inegi)
infagro <-inegi_series("628213", token_inegi)
infenerg <-inegi_series("628214", token_inegi)
#truco para juntar vectores de longitud diferente en el mismo df y usar las fechas del más largo
sq <- seq(max(length(infgeneral$date), length(infsub_total$date)))

inf_mensual <- data.frame(infgeneral$date[sq],
                          infgeneral$values[sq],
                          infsub_total$values[sq],
                          infmerc$values[sq], 
                          infserv$values[sq],
                          infnosub$values[sq],
                          infagro$values[sq],
                          infenerg$values[sq])
rm(infgeneral, 
   infsub_total, 
   infmerc,
   infserv, 
   infnosub,
   infagro,
   infenerg)
write.csv(inf_mensual, "DATA/inf_mensual_interanual.csv", row.names = FALSE)
rm(inf_mensual)

#inflación anual acumulada
#628215,628216,628217,628218,628219,628220,628221
infgeneral <-inegi_series("628215", token_inegi)
infsub_total <-inegi_series("628216", token_inegi)
infmerc <-inegi_series("628217", token_inegi) 
infserv <-inegi_series("628218", token_inegi)
infnosub <-inegi_series("628219", token_inegi)
infagro <-inegi_series("628220", token_inegi)
infenerg <-inegi_series("628221", token_inegi)
#truco para juntar vectores de longitud diferente en el mismo df y usar las fechas del más largo
sq <- seq(max(length(infgeneral$date), length(infsub_total$date)))

inf_mensual <- data.frame(infgeneral$date[sq],
                          infgeneral$values[sq],
                          infsub_total$values[sq],
                          infmerc$values[sq], 
                          infserv$values[sq],
                          infnosub$values[sq],
                          infagro$values[sq],
                          infenerg$values[sq])
rm(infgeneral, 
   infsub_total, 
   infmerc,
   infserv, 
   infnosub,
   infagro,
   infenerg)
write.csv(inf_mensual, "DATA/inf_anual.csv", row.names = FALSE)
rm(inf_mensual)


#inpc quincenal
#628222,628223,628224,628225,628226,628227,628228/
inpcgeneral <-inegi_series("628222", token_inegi)
inpcsub_total <-inegi_series("628223", token_inegi)
inpcmerc <-inegi_series("628224", token_inegi) 
inpcserv <-inegi_series("628225", token_inegi)
inpcnosub <-inegi_series("628226", token_inegi)
inpcagro <-inegi_series("628227", token_inegi)
inpcenerg <-inegi_series("628228", token_inegi)
#truco para juntar vectores de longitud diferente en el mismo df y usar las fechas del más largo
sq <- seq(max(length(inpcgeneral$date), length(inpcsub_total$date)))

inpc_q <- data.frame(inpcgeneral$date[sq],
                           inpcgeneral$values[sq],
                           inpcsub_total$values[sq],
                           inpcmerc$values[sq], 
                           inpcserv$values[sq],
                           inpcnosub$values[sq],
                           inpcagro$values[sq],
                           inpcenerg$values[sq])
rm(inpcgeneral, 
   inpcsub_total, 
   inpcmerc,
   inpcserv, 
   inpcnosub,
   inpcagro,
   inpcenerg)
write.csv(inpc_q, "DATA/inpc_q.csv", row.names = FALSE)
rm(inpc_q)

#inflacion quincenal
#628229,628230,628231,628232,628233,628234,628235
infgeneral <-inegi_series("628229", token_inegi)
infsub_total <-inegi_series("628230", token_inegi)
infmerc <-inegi_series("628231", token_inegi) 
infserv <-inegi_series("628232", token_inegi)
infnosub <-inegi_series("628233", token_inegi)
infagro <-inegi_series("628234", token_inegi)
infenerg <-inegi_series("628235", token_inegi)
#truco para juntar vectores de longitud diferente en el mismo df y usar las fechas del más largo
sq <- seq(max(length(infgeneral$date), length(infsub_total$date)))

inf_q <- data.frame(infgeneral$date[sq],
                     infgeneral$values[sq],
                     infsub_total$values[sq],
                     infmerc$values[sq], 
                     infserv$values[sq],
                     infnosub$values[sq],
                     infagro$values[sq],
                     infenerg$values[sq])
rm(infgeneral, 
   infsub_total, 
   infmerc,
   infserv, 
   infnosub,
   infagro,
   infenerg)
write.csv(inf_q, "DATA/inf_q.csv", row.names = FALSE)
rm(inf_q)

#sistema indicadores compuestos
#436139,436141
sic_coin <-inegi_series("436139", token_inegi)
sic_ad <- inegi_series("436141", token_inegi)
sic <- data.frame(sic_coin$date,
                  sic_coin$values,
                  sic_ad$values)
rm(sic_coin, sic_ad)
write.csv(sic, "DATA/sic.csv", row.names = FALSE)
rm(sic)
#tasa de desocupación
#444666,444720,444774
des_tot <- inegi_series("444666", token_inegi)
des_h <- inegi_series("444720", token_inegi)
des_m <- inegi_series("444774", token_inegi)
des <- data.frame(des_tot$date,
                  des_tot$values,
                  des_h$values,
                  des_m$values)
rm(des_tot,des_h,des_m)
write.csv(des, "DATA/des.csv", row.names = FALSE)
rm(des)

#valor de la construcción
#661100,661104,661108,661076,661080,661084,661088,661092,661096  
total <- inegi_series("661100", token_inegi)
pub <- inegi_series("661104", token_inegi)
priv <- inegi_series("661108", token_inegi)
edif <- inegi_series("661076", token_inegi)
agua <- inegi_series("661080", token_inegi)
elec <- inegi_series("661084", token_inegi)
trans <- inegi_series("661088", token_inegi)
petr <- inegi_series("661092", token_inegi)
otras <- inegi_series("661096", token_inegi)
construc <- data.frame(total$date,
                       total$values,
                       pub$values,
                       priv$values,
                       edif$values,
                       agua$values,
                       elec$values,
                       trans$values,
                       petr$values,
                       otras$values)
rm(total,pub,priv,edif,agua,elec,trans,petr,otras)
write.csv(construc, "DATA/construc.csv", row.names = FALSE)
rm(construc)

#vehiculos auto
#15166,15167,15168,15169,15170,15171,15172,15173,15174,119328,119329,119330
prod <- inegi_series("15166", token_inegi)
auto <- inegi_series("15167", token_inegi)
cam <- inegi_series("15168", token_inegi)
ventaauto <- inegi_series("15169", token_inegi)
sub <- inegi_series("15170", token_inegi)
comp <- inegi_series("15171", token_inegi)
lujo <- inegi_series("15172", token_inegi)
sport <- inegi_series("15173", token_inegi)
import <- inegi_series("15174", token_inegi)
cam1 <- inegi_series("119328", token_inegi)
nac <- inegi_series("119329", token_inegi)
importcam <- inegi_series("119330", token_inegi)
sq <- seq(max(length(prod$date), length(nac$date)))
automot <- data.frame(prod$date[sq],
                   prod$values[sq],
                   auto$values[sq],
                   cam$values[sq],
                   ventaauto$values[sq],
                   sub$values[sq],
                   comp$values[sq],
                   lujo$values[sq],
                   sport$values[sq],
                   import$values[sq],
                   cam1$values[sq],
                   nac$values[sq],
                   importcam$values[sq]
                   )
rm(prod,auto,cam,ventaauto,sub,comp,lujo,sport,import,cam1,nac,importcam,sq)
write.csv(automot, "DATA/automot.csv", row.names = FALSE)
rm(automot)


#PIB 2021-02-23
pibseries <- c(493621,493622,493623,493624,493625,493626,493627,493628,493629,493630,
               493631,499231,493632,493633,493634,493635,493636,493637,493638,493639,
               493640,493641,493642,493643,493644)
pib <- lapply(pibseries, inegi_series, token_inegi)
sq <- seq(max(length(pib[[1]]$date), length(pib[[24]]$date)))

pib <- data.frame(pib[[1]]$date[sq],pib[[1]]$values[sq],
                   pib[[2]]$values[sq],pib[[3]]$values[sq],
                   pib[[4]]$values[sq],pib[[5]]$values[sq],pib[[6]]$values[sq],
                   pib[[7]]$values[sq],pib[[8]]$values[sq],pib[[9]]$values[sq],
                   pib[[10]]$values[sq],pib[[11]]$values[sq],pib[[12]]$values[sq],
                   pib[[13]]$values[sq],pib[[14]]$values[sq],pib[[15]]$values[sq],
                   pib[[16]]$values[sq],pib[[17]]$values[sq],pib[[18]]$values[sq],
                   pib[[19]]$values[sq],pib[[20]]$values[sq],pib[[21]]$values[sq],
                   pib[[22]]$values[sq],pib[[23]]$values[sq],pib[[24]]$values[sq],
                  pib[[25]]$values[sq]
                   )
write.csv(pib, "DATA/pibmex.csv", row.names=FALSE)
rm(pib, pibseries, sq)

#IGAE
igaeseries <- c(496150,496151,496152,496153,496154,496155,496156,496157,496158,499227,
                496159,496160,496161,496162,496163,496164,496165)
igae <- lapply(igaeseries, inegi_series, token_inegi)
sq <- seq(max(length(igae[[1]]$date), length(igae[[17]]$date)))
igae <- data.frame(igae[[1]]$date[sq],igae[[1]]$values[sq],
                   igae[[2]]$values[sq],igae[[3]]$values[sq],igae[[4]]$values[sq],
                   igae[[5]]$values[sq],igae[[6]]$values[sq],igae[[7]]$values[sq],
                   igae[[8]]$values[sq],igae[[9]]$values[sq],igae[[10]]$values[sq],
                   igae[[11]]$values[sq],igae[[12]]$values[sq],igae[[13]]$values[sq],
                   igae[[14]]$values[sq],igae[[15]]$values[sq],igae[[16]]$values[sq],
                   igae[[17]]$values[sq])
write.csv(igae, "DATA/igae.csv", row.names=FALSE)
rm(igae, igaeseries, sq)

#IGAE desest 2021-02-23
igaeseries <- c(496216, 496223,496230,496237,496244,496251,496258,496265,496272,515886,
                496279,496286,496293,496300,496307,496314,496321)
igae <- lapply(igaeseries, inegi_series, token_inegi)
sq <- seq(max(length(igae[[1]]$date), length(igae[[17]]$date)))
igae <- data.frame(igae[[1]]$date[sq],igae[[1]]$values[sq],
                   igae[[2]]$values[sq],igae[[3]]$values[sq],igae[[4]]$values[sq],
                   igae[[5]]$values[sq],igae[[6]]$values[sq],igae[[7]]$values[sq],
                   igae[[8]]$values[sq],igae[[9]]$values[sq],igae[[10]]$values[sq],
                   igae[[11]]$values[sq],igae[[12]]$values[sq],igae[[13]]$values[sq],
                   igae[[14]]$values[sq],igae[[15]]$values[sq],igae[[16]]$values[sq],
                   igae[[17]]$values[sq])
write.csv(igae, "DATA/igae1.csv", row.names=FALSE)
rm(igae, igaeseries, sq)


#series de banxico
library(siebanxicor)
#actualizar token en sitio de banxico cuando haga falta: https://www.banxico.org.mx/SieAPIRest/service/v1/token
setToken("c60a5aa65615365fe1ecdd509dc96435a3e5c3cac6b27a2cbad82b747d18662a")
#reservas internacionales MdD mensual

idSeries <- c("SF110168", "SF110179")
serie <- getSeriesData(idSeries)
write.csv(serie,"DATA/reservas.csv", row.names = FALSE )
#reservas internacionales banxico MdD semanales
idSeries <- c("SF43707")
serie <- getSeriesData(idSeries)
write.csv(serie,"DATA/reservas_semanales.csv", row.names = FALSE )
#remesas familiares total (MdD)
idSeries <- c("SE27803")
serie <- getSeriesData(idSeries)
write.csv(serie,"DATA/remesas_fam.csv", row.names = FALSE )

#tipo forwards de swaps
idSeries <- c("SF290111",	"SF290112",	"SF290113",
              "SF290114",	"SF290115",	"SF290116",	
              "SF290117",	"SF290118",	"SF290119",
              "SF290120",	"SF290121",	"SF290122",	
              "SF290123",	"SF290124",	"SF290125",
              "SF290126",	"SF290127",	"SF290128",
              "SF290129",	"SF290130",	"SF290131",	
              "SF290132")
serie <- getSeriesData(idSeries)
serie <-data.frame(serie)
serie <- serie[,-c(3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,
                   37,39,41,43)]
write.csv(serie,"DATA/forward_mxn_swaps.csv", row.names = FALSE )
#tasas forwards mxn de swaps
forward_mxn_swaps_data <- read.csv("DATA/forward_mxn_swaps.csv")
rownames(forward_mxn_swaps_data) <- forward_mxn_swaps_data[,1]
forward_mxn_swaps_data[,1] <- NULL
colnames(forward_mxn_swaps_data) <- c("1-7d", "8-30d", "31-60d",
                                      "61-90d", "91-120d", "121-150d",
                                      "151-180d", "181-210d", "211-240d",
                                      "241-270d", "271-300d", "301-330d",
                                      "331-360d", "361-731d", "732-1096d",
                                      "1097-1461d", "1462-1827d", "1828-2557d",
                                      "2558-3653d", "3654-5479d", "5480-7305d",
                                      "Over 7306d")
forward_mxn_swaps_data <- na.omit(forward_mxn_swaps_data)
dbWriteTable(asapadb_remote, "forward_mxn_swaps", forward_mxn_swaps_data, row.names = TRUE, overwrite = TRUE )




rm(idSeries, date)
rm(serie)



#series USA
library(fredr)
library(tidyr)

api <- "04e993066c49173bd311b63234e2aad4"
fredr_set_key(api)

#business sales and inv
mtis <- fredr_release_series(release_id = 25)
if (requireNamespace("purrr", quietly = TRUE)) {
   series <- c("TOTBUSSMSA",
               "AMTMVS",
               "RSXFS",
               "S42SMSM144SCEN",
               "BUSINV",
               "AMTMTI",
               "RETAILIMSA",
               "I423IMM144SCEN",
               "R42IRSM163SCEN"
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series,
      frequency = c("m")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x, frequency = .y)
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/businessSalesInv.csv", row.names = FALSE)
rm(df,mtis,params,series)


#surveys of consumers
consurvey <- fredr_release_series(release_id = 91)
if (requireNamespace("purrr", quietly = TRUE)) {
   series <- consurvey$id[c(1,2)]
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series,
      frequency = c("m")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x, frequency = .y)
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/consurvey.csv", row.names = FALSE)
rm(df,consurvey,params,series)


#construction spending
conspending <- fredr_release_series(release_id = 229)
if (requireNamespace("purrr", quietly = TRUE)) {
   series <- conspending$id
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series,
      frequency = c("m")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x, frequency = .y)
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/conspending.csv", row.names = FALSE)
rm(df,conspending,params,series)


#consumer credit

conscredit <- fredr_release_series(release_id = 14)
if (requireNamespace("purrr", quietly = TRUE)) {
   series <- c(
      "TOTALSL",
      "REVOLSL",
      "NONREVSL"
      
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
                   )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/conscredit.csv", row.names = FALSE)
rm(df,conscredit,params,series)

#gdp index 2012
gdp_index <- fredr_release_series(release_id = 53)
if (requireNamespace("purrr", quietly = TRUE)) {
   series <- gdp_index$id[which (gdp_index$units == "Index 2012=100" & gdp_index$frequency=="Annual" )]
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/gdp_index.csv", row.names = FALSE)
rm(df,gdp_index,params,series)


#gdp dollars adjusted
gdp <- fredr_release_series(release_id = 53)
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c(
      "GDPC1",
      "PCECC96",
      "DGDSRX1Q020SBEA",
      "PCDGCC96",
      "PCNDGC96",
      "PCESVC96",
      "GPDIC1",
      "FPIC1",
      "PNFIC1",
      "B009RX1Q020SBEA",
      "Y033RX1Q020SBEA",
      "Y001RX1Q020SBEA",
      "PRFIC1",
      "CBIC1",
      "NETEXC",
      "EXPGSC1",
      "A253RX1Q020SBEA",
      "A646RX1Q020SBEA",
      "IMPGSC1",
      "A255RX1Q020SBEA",
      "B656RX1Q020SBEA",
      "GCEC1",
      "FGCEC1",
      "A824RX1Q020SBEA",
      "A825RX1Q020SBEA",
      "SLCEC1",
      "A960RX1Q020SBEA"
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/gdp_sa.csv", row.names = FALSE)
rm(df,gdp,params,series)


#cpi
cpi <- fredr_release_series(release_id = 10)
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c(
      "CPIAUCSL",
      "CPILFESL",
      "PCEPI",
      "CPIAUCNS",
      "CPILFENS"
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/cpi.csv", row.names = FALSE)
rm(df,cpi,params,series)

#ppi
ppi <- fredr_release_series(release_id = 46)
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c("WPSFD49207",
              "WPUFD4131",
              "PPIFIS")
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/ppi.csv", row.names = FALSE)
rm(df,ppi,params,series)


#manufacturers orders, invs and shipments id 95
manuf <- fredr_release_series(release_id = 95)
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c("IPMAN",
              "PCUOMFGOMFG",
              "AMTMNO",
              "AMXDNO",
              "AMXTNO",
              "DGORDER",
              "ADXTNO",
              "ADXDNO")
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/manuf.csv", row.names = FALSE)
rm(df,manuf,params,series)

#desempleo general EEUU
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c("UNRATE",
              "UNEMPLOY",
              "AWHNONAG",
              "AHETPI"
              
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/unemp.csv", row.names = FALSE)
rm(df,params,series)


#seguro de desempleo EEUU
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c("IURSA",
      "ICSA",
              "CCSA",
              "IC4WSA"
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/claims.csv", row.names = FALSE)
rm(df,params,series)

#personal income
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c("PI",
              "W209RC1",
              "A576RC1",
              "A132RC1",
              "B202RC1",
              "B040RC1M027SBEA",
                 "A041RC1",
              "B042RC1",
              "A045RC1",
              "A048RC1",
                 "PIROA",
              "PII",
              "PDI",
              "PCTR",
              "A063RC1",
              "W823RC1",
              "W825RC1",
              
              "B931RC1",
              "A061RC1",
              "W055RC1",
              "DSPI",
              "A068RC1",
              "PCE",
              "B069RC1",
              "W875RX1",
              "PMSAVE",
              "PSAVERT",
              
              "A229RC0",
              
              "POPTHM"
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/income.csv", row.names = FALSE)
rm(df,params,series)

#wholesale trade
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c("S42SMSM144SCEN",
              "S423SMM144SCEN",
              "S4231SM144SCEN",
              "S4232SM144SCEN",
              "S4233SM144SCEN",
              "S42343M144SCEN",
              "S42343M144SCEN",
              "S4235SM144SCEN",
              "S4236SM144SCEN",
              "S4237SM144SCEN",
              "S4238SM144SCEN",
              "S4239SM144SCEN",
              "S4241SM144SCEN",
              "S4242SM144SCEN",
              "S4243SM144SCEN",
              "S4244SM144SCEN",
              "S4245SM144SCEN",
              "S4246SM144SCEN",
              "S4247SM144SCEN",
              "S4248SM144SCEN",
              "S4249SM144SCEN",
              "I42IMSM144SCEN",
              "I4231IM144SCEN",
              "I4232IM144SCEN",
              "I4233IM144SCEN",
              "I4234IM144SCEN",
              "I42343M144SCEN",
              "I4235IM144SCEN",
              "I4236IM144SCEN",
              "I4237IM144SCEN",
              "I4238IM144SCEN",
              "I4239IM144SCEN",
              "I4239IM144SCEN",
              "I4241IM144SCEN",
              "I4242IM144SCEN",
              "I4243IM144SCEN",
              "I4244IM144SCEN",
              "I4245IM144SCEN",
                 "I4246IM144SCEN",
                 "I4247IM144SCEN",
                 "I4248IM144SCEN",
                 "I4249IM144SCEN",
                 "R42IRSM163SCEN",
                 "R423IRM163SCEN",
                 "R4231IM163SCEN",
                 "R4232IM163SCEN",
                 "R4233IM163SCEN",
                 "R4234IM163SCEN",
                 "R42343M163SCEN",
                 "R4235IM163SCEN",
                 "R4236IM163SCEN",
                 "R4237IM163SCEN",
                 "R4238IM163SCEN",
                 "R4239IM163SCEN",
                 "R424IRM163SCEN",
                 "R4241IM163SCEN",
                 "R4242IM163SCEN",
                 "R4243IM163SCEN",
                 "R4244IM163SCEN",
                 "R4245IM163SCEN",
                 "R4246IM163SCEN",
                 "R4247IM163SCEN",
                 "R4248IM163SCEN",
                 "R4249IM163SCEN"
                 
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% distinct() %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/wholesale.csv", row.names = FALSE)
rm(df,params,series)

# retail
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c("MRTSSM44X72USS",
              "MRTSSM44Y72USS",
              "MRTSSM441USS",
              "MRTSSM441XUSS",
              "MRTSSM4413USS"
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/retail.csv", row.names = FALSE)
rm(df,params,series)


# adv retail
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c("RSAFS",
              "RSFSXMV",
              "RSMVPD",
              "RSAOMV"
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/advretail.csv", row.names = FALSE)
rm(df,params,series)





#ventas autos
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c("LAUTONSA",
              "LTRUCKNSA",
              "LTOTALNSA",
              "TOTALNSA",
              "LAUTOSA",
              "LTRUCKSA",
              "ALTSALES",
              "TOTALSA"
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/autos.csv", row.names = FALSE)
rm(df,params,series)

#cpi international
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c("CHNCPIALLMINMEI",
              "USACPIALLMINMEI",
              "JPNCPIALLMINMEI",
              "GBRCPIALLMINMEI",
              "INDCPIALLMINMEI",
              "DEUCPIALLMINMEI",
              "BRACPIALLMINMEI",
              "FRACPIALLMINMEI",
              "MEXCPIALLMINMEI",
              "RUSCPIALLMINMEI"
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/cpi_int.csv", row.names = FALSE)
rm(df,params,series)

#housing starts
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c("HOUST",
              "HOUST1F",
              "HOUST5F",
              "HOUSTNE",
              "HOUSTNE1F",
              "HOUSTMW",
              "HOUSTMW1F",
              "HOUSTS",
              "HOUSTS1F",
              "HOUSTW",
              "HOUSTW1F"
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/houst.csv", row.names = FALSE)
rm(df,params,series) 

#building permits
if (requireNamespace("purrr", quietly = TRUE)) {
   series <-c("PERMIT",
              "PERMIT1",
              "PERMIT24",
              "PERMIT5",
              "PERMITNE",
              "PERMITNE1",
              "PERMITMW",
              "PERMITMW1",
              "PERMITS",
              "PERMITS1",
              "PERMITW",
              "PERMITW1"
   )
   library(purrr)
   purrr::map_dfr(series, fredr)
   
   # Using purrr::pmap_dfr() allows you to use varying optional parameters
   params <- list(
      series_id = series
      #,frequency = c("m", "meop", "qeop")
   )
   
   df <- purrr::pmap_dfr(
      .l = params,
      .f = ~ fredr(series_id = .x
                   #, frequency = .y
      )
   )
   
}
df <-df %>% pivot_wider(id_cols = "date", names_from = "series_id")
write.csv(df, "DATA/permits.csv", row.names = FALSE)
rm(df,params,series) 





#quandl data
library(Quandl)

Quandl.api_key("AHqoaD3sqFSfLxKBu_pF")

pmi_comp <- Quandl("ISM/MAN_PMI", type = "xts")
new_ord <- Quandl("ISM/MAN_NEWORDERS", type = "xts")[,5]
prod <- Quandl("ISM/MAN_PROD", type = "xts")[,5]
employ <- Quandl("ISM/MAN_EMPL", type = "xts")[,5]
deliv <- Quandl("ISM/MAN_DELIV", type = "xts")[,5]
maninv <-Quandl("ISM/MAN_INVENT", type = "xts")[,5]
custinv <- Quandl("ISM/MAN_CUSTINV", type = "xts")[,5]
prices <- Quandl("ISM/MAN_PRICES", type = "xts")[,5]
backlog <- Quandl("ISM/MAN_BACKLOG", type = "xts")[,5]
exports <- Quandl("ISM/MAN_EXPORTS", type = "xts")[,5]
imports <- Quandl("ISM/MAN_IMPORTS", type = "xts")[,5]

ism <- cbind(pmi_comp, 
      new_ord, 
      prod,
      employ,
      deliv, 
      maninv, 
      custinv,
      prices, 
      backlog, 
      exports, 
      imports)
colnames(ism) <- c("pmi_comp", 
                   "new_ord", 
                   "prod",
                   "employ",
                   "deliv", 
                   "maninv", 
                   "custinv",
                   "prices", 
                   "backlog", 
                   "exports", 
                   "imports")
write.csv(ism, "DATA/ism.csv", row.names = as.Date(index(ism)))

#ism serv
nmi <- Quandl("ISM/NONMAN_NMI", type = "xts")
busact <- Quandl("ISM/NONMAN_BUSACT", type = "xts")[,4]
neword <- Quandl("ISM/NONMAN_NEWORD", type = "xts")[,4]
empl <- Quandl("ISM/NONMAN_EMPL", type = "xts")[,4]
deliv <- Quandl("ISM/NONMAN_DELIV", type = "xts")[,4]
invent <- Quandl("ISM/NONMAN_INVENT", type = "xts")[,4]
prices <-Quandl("ISM/NONMAN_PRICES", type = "xts")[,4]
backlog <- Quandl("ISM/NONMAN_BACKLOG", type = "xts")[,4]
exports <- Quandl("ISM/NONMAN_EXPORTS", type = "xts")[,4]
imports <- Quandl("ISM/NONMAN_IMPORTS", type = "xts")[,4]
invsent <- Quandl("ISM/NONMAN_INVSENT", type = "xts")[,4]

ism_s <- cbind(nmi, 
               busact, 
               neword, 
               empl, 
               deliv,
               invent,
               prices,
               backlog, 
               exports, 
               imports, 
               invsent)
colnames(ism_s) <- c("nmi", 
                   "busact", 
                   "neword", 
                   "empl", 
                   "deliv",
                   "invent",
                   "prices",
                   "backlog", 
                   "exports", 
                   "imports", 
                   "invsent")
write.csv(ism_s, "DATA/ism_s.csv", row.names = as.Date(index(ism_s)))



