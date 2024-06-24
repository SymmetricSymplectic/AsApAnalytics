#cuentas del modelo analtec
library(tidyverse)

asapadb_remote = dbConnect(MySQL(),  #remote is to be used for dbms
                           user='Felix', 
                           password='XkxY1BgiwXFpTWvF', 
                           dbname='SisAna', 
                           host='146.190.57.35',
                           port = as.numeric("3306"))
test <- dbReadTable(conn=asapadb_remote, "amx")

#model data comes from the "historico" tab, 
#INPC factor must be applied to all series to obtain "actualizados" 


ToFactor <- function(series,factor){
  require(tidyverse)
  output <-series*factor
  
  return(output)
}

#this gives us 12m data for the series that require it
To12months <- function(series){
  require(tidyverse)
  output <-series + lag(series) +lag(series, 2)+lag(series, 3)
  
  return(output)
}

#this gives us quarterly data (results acc data is presented as cumulative results for current year)

IndivTrim <-function(series, trim){
  require(tidyverse)
  output <-if_else(trim >= 2, series - lag(series), series)
  return(output)
}
#para las cuentas de rotacion donde se sacan promedios ult 4 trimestres
YearlyMean <-function(series){
  require(tidyverse)
  output <-(series+ lag(series)+ lag(series,2)+ lag(series,3))/4
  return(output)
}


analtec_model <- function(data){
  require(tidyverse)
  output <- data
  output <-  output %>%
    select(-c(Factor.INPC, Factor.Ajuste.No..Acciones,Trim.Base))%>%
    ToFactor( factor = data$Factor.INPC)
  output <-  output %>%
    mutate(VentasNetasTrim = IndivTrim(ERA1, data$Trim.Base))%>%
    mutate(UtilidadBrutaTrim = IndivTrim(ERA3,data$Trim.Base))%>%
    mutate(GastosVentaTrim = IndivTrim(ERA2, data$Trim.Base) )%>% 
    mutate(GastosGeneralesTrim = IndivTrim(ERA4+ERA5,data$Trim.Base)   )%>%
    mutate(UtilidadOpTrim = IndivTrim(ERA8,data$Trim.Base)   )%>%
    mutate(Uafida = ERA8 + DIERA1)%>%
    mutate(FlujoEfectivo = (ERA3 + DIERA1- ERIA12)* (ERA17/ERA16) )%>%
    mutate(FlujoEfectivoTrim = IndivTrim(FlujoEfectivo,data$Trim.Base ))%>%
    mutate(UafidaTrim = IndivTrim( Uafida, data$Trim.Base) ) %>%
    mutate(UtilidadNetaConsolidadaTrim = IndivTrim(ERA16, data$Trim.Base) )%>%
    mutate(UtilidadNetaMayoritariaTrim = IndivTrim(ERA17,data$Trim.Base ) ) %>%
    mutate(VentasNeta12M =  To12months(VentasNetasTrim)) %>%
    mutate(UtilidadBruta12M  = To12months(UtilidadBrutaTrim)) %>%
    mutate(GastosVenta12M  = To12months(GastosVentaTrim)) %>%
    mutate(Gastos_Generales12M = To12months(GastosGeneralesTrim))%>%
    mutate(UtilidadOperación12M = To12months(UtilidadOpTrim) )%>%
    mutate(Uafida12M = To12months(UafidaTrim))%>%
    mutate(FlujoEfectivo12M = To12months(FlujoEfectivoTrim))%>%
    mutate(UtilidadNetaConsolidada12M = To12months(UtilidadNetaConsolidadaTrim) )%>%
    mutate(UtilidadNetaMayoritaria12M = To12months(UtilidadNetaMayoritariaTrim) ) %>%
    mutate(CostoVentasTrim  = IndivTrim(ERA2, data$Trim.Base) )%>%
    

    #Razones de Liquidez
    mutate(CapitalTrabajo = ESFT10 - ESFT37)%>%
    mutate(ActivoCirc_PasivoCP = ESFT10/ESFT37)%>%
    mutate(ActCircMenosInvent_PasivoCP = (ESFT10 - ESFT5)/ESFT37)%>%
    mutate(ActCirc_PasivoTot = ESFT10 / ESFT48 )%>%
    mutate(ActDisp_PasivoCP = ESFT1 / ESFT37)%>%
    mutate(MargenSeguridad = CapitalTrabajo/ESFT37)%>%
    mutate(ActDisp_ActTot = ESFT1 / ESFT26)%>%
    #razones de apalancamiento
    mutate(PasivoCosto = ESFT29 + ESFT40)%>%
    mutate(PasivoTot_CapContable = ESFT48 / ESFT56)%>%
    mutate(PasivoTot_ActivoTot = ESFT48 / ESFT26 )%>%
    mutate(Proveedores_PasivoTot  =ESFT27 / ESFT48)%>%
    mutate(PasivoCosto_CapContable = PasivoCosto/ESFT56)%>%
    mutate(PasivoCosto_PasivoTotal = PasivoCosto/ESFT48)%>%
    mutate(IntPagados_PasivoCosto =  (ERT10 + lag(ERT10) + lag(ERT10,2) + lag(ERT10,3))/PasivoCosto)%>%
    mutate(Uafida12M = UafidaTrim + lag(UafidaTrim) + lag(UafidaTrim, 2) + lag(UafidaTrim, 3 ))%>%
    mutate(Uafida_IntPagados = Uafida12M/(To12months(IndivTrim(ERA10,data$Trim.Base )) ))  %>%
    mutate(DeudaNeta_Uafida = (PasivoCosto - ESFT1)/Uafida12M )%>%
    #Rotacion
    mutate(Ventas_ActTotal = VentasNeta12M /ESFT26  )%>%
    mutate(Ventas_ActFijo = VentasNeta12M /ESFT18  )%>%
    mutate(Ventas_CapContable = VentasNeta12M /ESFT56  )%>%
    mutate(RotacionInventarios_dias = (365/4)*( To12months(ESFT5) ) / (To12months(CostoVentasTrim)))%>%
    mutate(RotacionInventarios_veces = 365/RotacionInventarios_dias)%>%
    mutate(PlazoPromedioPagoProveedores_dias = (365)*(YearlyMean(ESFT27))/  (To12months(CostoVentasTrim)))  %>%
    mutate(PlazoPromedioPagoProveedores_Veces = 365/PlazoPromedioPagoProveedores_dias )  %>%
    mutate(RotacionCuentasCobrar_dias = (365)* (YearlyMean(ESFT2)/( 1+data$IVA) ) / (To12months(VentasNetasTrim) )) %>%
    mutate(RotacionCuentasCobrar_veces = 365/RotacionCuentasCobrar_dias ) %>%
    mutate(RotacionCapTrabajo = VentasNeta12M / CapitalTrabajo)%>%
    mutate(EstacionalidadVentas = VentasNetasTrim/ VentasNeta12M)%>%
    #Margenes
    
    mutate(MargenBruto12M = UtilidadBruta12M/VentasNeta12M)%>%
    mutate(MargenOperacion12M = UtilidadOperación12M/VentasNeta12M)%>%
    mutate(MargenUafida12M  = Uafida12M/VentasNeta12M)%>%
    mutate(MargenNeto12MConsolidado = UtilidadNetaConsolidada12M/VentasNeta12M )%>%
    mutate(MargenNeto12MMayoritario = UtilidadNetaMayoritaria12M/VentasNeta12M )%>%
    mutate(MargenBrutoAcTrimestre = ERA3/ERA1)%>%
    mutate(MargenOperacionAcTrimestre  = ERA8/ERA1)%>%
    mutate(MargenUafidaAcTrimestre = Uafida/ERA1)%>%
    mutate(MargenNetoAcTrimestreConsol = ERA16/ERA1)%>%
    mutate(MargenNetoAcTrimestreMayor = ERA17/ERA1)%>%
    mutate(MargenBrutoTrim = UtilidadBrutaTrim/VentasNetasTrim)%>%
    mutate(MargenOperacionTrim  = UtilidadOpTrim/VentasNetasTrim)%>%
    mutate(MargenUafidaTrim = UafidaTrim/VentasNetasTrim)%>%
    mutate(MargenNetoTrimConsol = UtilidadNetaConsolidadaTrim/VentasNetasTrim)%>%
    mutate(MargenNetoTrimMayor = UtilidadNetaMayoritariaTrim/VentasNetasTrim)%>%
    #rentabilidad
    mutate(UtilidadMayor_CapContableMayor = UtilidadNetaMayoritaria12M/ESFT54)%>%
    mutate(UtilidadNetaCons_ActivoTotal = UtilidadNetaConsolidada12M/ESFT26)%>%
    mutate(UtilidadNetaCons_ActivoFijo = UtilidadNetaConsolidada12M/ ESFT18)%>%
    mutate(GastosPorcUtilidadBruta = Gastos_Generales12M/UtilidadBruta12M)%>%
    mutate(CostoVentas_Ventas = GastosVenta12M/VentasNeta12M)%>%
    mutate(GastosOperación_Ventas =Gastos_Generales12M/VentasNeta12M)%>%
    mutate(GastosOperación_UtilidadBruta = Gastos_Generales12M/UtilidadBruta12M )%>%
    #datos por accion (acciones en Circ es DIESFT7)
    mutate(UPA = UtilidadNetaMayoritaria12M/DIESFT7)%>%
    mutate(VLA = ESFT54/DIESFT7)%>%
    mutate(Uafida_Accion = Uafida12M/DIESFT7)%>%
    mutate(FlujoEfectivo_Accion = FlujoEfectivo12M/DIESFT7)%>%
    mutate( VentasNetas_Accion = VentasNeta12M/DIESFT7)%>%
    mutate(EfectivoInvTemp_Accion = ESFT1/DIESFT7)%>%
    mutate( PasivoCosto_Accion = PasivoCosto/DIESFT7)%>%
    mutate( CapContableMin_Accion =ESFT55/DIESFT7)%>%
    mutate(VEPA = CapContableMin_Accion+PasivoCosto_Accion-EfectivoInvTemp_Accion)
    

  return(output)
}


result <- analtec_model(test)

#prueba anual
VentaAnuales <- result%>%group_by(lubridate::year(rownames(result)))%>%mutate(VentasAnuales = sum(VentasNetasTrim))


#razones financieras












#implementacion que imita las hoja de cálculo

#actualizados es multiplicar históricos por FactorINPC

test_act <- test %>%
  select(-c(Factor.INPC, Factor.Ajuste.No..Acciones,Trim.Base, IVA, Equivalencia.CPOs))%>%
  ToFactor( factor = test$Factor.INPC)




