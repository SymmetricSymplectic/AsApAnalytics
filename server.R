library(shiny)
library(shinyjs)
library(shinyWidgets)
library(shinythemes)
library(htmlwidgets)
library(htmltools)
library(xts)
library(readxl)
library(forecast)
library(sweep)
library(zoo)
library(scales)
library(data.table)
library(ggplot2)
library(ggfortify)
library(ggpubr)
library(png)
library(grid)
library(lubridate)
library(plotly)
library(TSstudio)
library(corrplot)
#library(tsibble)
library(tibble)
library(readr)


source("preprocessing_master.R", local = TRUE)

#percentchange function for ts
pch <- function(data, lag = 1) {
  # argument verification
  # return percent change
  data / lag(data, -lag) - 1
}

#function to turn forecast objects into arrays
gen_array <- function(forecast_obj){
  
  actuals <- forecast_obj$x
  lower <- forecast_obj$lower[,2]
  upper <- forecast_obj$upper[,2]
  point_forecast <- forecast_obj$mean
  
  cbind(actuals, lower, upper, point_forecast)
}

#función que cuenta número de meses entre fechas
elapsed_months <- function(end_date, start_date) {
  ed <- as.POSIXlt(end_date)
  sd <- as.POSIXlt(start_date)
  12 * (ed$year - sd$year) + (ed$mon - sd$mon)
}


#definimos servidor para graficar las series de tiempo
server <- function(input, output, session){
  #input condicional: serie de datos a analizar
  datasetInput <- reactive({
    switch(input$dataset,
           "Balanza Comercial" = balanza_data,
           "Establecimientos Comerciales" = establecimientos_data,
           "Indicador Global de Actividad Económica (Desestacionalizado)" = igae1_data,
           "Indicador Global de Actividad Económica (Original)" =igae_data,
           "Índice Mensual de Actividad Industrial (Original)" = actind_data,
           "Índice Mensual de Actividad Industrial (Desestacionalizado)" = imai_data,
           "Indicador Mensual de Consumo Privado en el Mercado Interior (Original)" =imcp_data,
           "Indicador Mensual de Consumo Privado en el Mercado Interior (Desestacionalizado)" =imcp_desest_data,
           "Indicador de Confianza del Consumidor" =confianza_data,
           "Índice Nacional de Precios al Consumidor (Mensual)" =inpc_mensual_data,
           "Índice Nacional de Precios al Consumidor (Quincenal)"= inpc_q_data,
           "Inflación (Mensual)" = inf_mensual_data,
           "Inflación (Mensual, Interanual)" = inf_mensual_interanual_data,
           "Inflación (Anual acumulada)" = inf_anual_data,
           "Inflación (Quincenal)"= inf_q_data,
           "Inversión Fija Bruta (Original)" = ifb_data,
           "Inversión Fija Bruta (Desestacionalizada)" = ifbdesest_data,
           "Producto Interno Bruto (a precios de 2013)" = pibmex_data,
           "Reservas Internacionales (Mensual)" = reservas_data,
           "Reservas Internacionales (Semanal)" = reservas_semanales_data,
           "Remesas" = remesas_fam_data,
           "Sistema de Indicadores Compuestos" = sic_data,
           "Tasa de Desocupación" = des_data,
           "Valor de la construcción" = construc_data,
           "Vehículos Automotores" = automot_data
           
    )
  })
  
  
  
  #input condicional: periodos a pronosticar
  fcperiodInput <- reactive({
    switch(input$fcperiod,
           "6"=6,
           "12"=12,
           "24"=24)
    
  })
  
  
  
  
  #crear los checkboxes de las series dinámicamente (principal)
  output$selectseries <- renderUI({
    selectizeInput("series", "Series a mostrar", names(datasetInput()),
                      multiple = TRUE
    )
  })
  #crear las listas de las series dinámicamente (pronóstico)
  output$selectforecast <- renderUI({
    selectInput("seriesforecast", "Escoja una serie para pronóstico", choices = names(datasetInput()))
  })
  #crear listas dinámicas (correlación)
  output$seriescorr1 <- renderUI({
    selectInput("corr1", "Escoja la serie 1 para el análisis de dispersión", choices= names(datasetInput()))
  })  
  output$seriescorr2 <- renderUI({
    selectInput("corr2", "Escoja la serie 2 para el análisis de dispersión", choices= names(datasetInput()))
  })     
  
  #generamos la gráfica de las series principales
  output$plotly1<- renderPlotly({
    req(input$series)
    data <- datasetInput()
    selseries <- data[,input$series]
    names(selseries) <- abbreviate(names(selseries), minlength = 16)
    don <- xts(x = selseries, order.by = as.Date(rownames(data)))
    varmen <-pch(don)
    varan <- pch(don, lag = 12)
    seriestype <- switch(input$sertype,
                         princ=don,
                         varmensual = varmen,
                         varanual = varan
    )
    
    equis <- rownames(data)
    ts_plot(seriestype, 
            title = paste(input$dataset, ":", input$series[1], sep= ""),
            Xtitle = "Fecha",
            Xgrid = TRUE,
            Ygrid = TRUE) %>%
      layout(plot_bgcolor='transparent',
             yaxis = list(gridcolor= "#AAAAAA", fixedrange = FALSE, autorange = TRUE,tickformat = "digit" ),
             xaxis = list(gridcolor= "#AAAAAA", ticktext = equis
                          #,rangeslider = list(type = "date")
             ),
             height = 650) %>% 
      layout(legend = list(x = 0.05, y = 0.95)) %>%
      layout(
        images = list(
          list(source = "https://i.ibb.co/2KDKzhg/logotipo-asapa-min-black.png",
               xref = "paper",
               yref = "paper",
               x= 0.15,
               y= 0.7,
               sizex = 0.8,
               sizey = 0.8,
               #sizing = "stretch",
               layer = "below",
               opacity = 0.1
          ))) %>%
      config(displaylogo = FALSE)
    
    #will also accept paper_bgcolor='black' or paper_bgcolor='transparent'
  })
  
  #texto que describe la serie Inegi elegida
  output$series_descrip <- renderText({
    attr(datasetInput(),"doc")
  })
  #tabla con los datos de la serie
  output$tabla <- renderDataTable( rownames_to_column(datasetInput(), var = "fecha") %>% as_tibble())
  
  #texto que describe los modelos arima y arfima
  output$forecast_descrip <- renderText({
    paste("El modelo ARIMA es una metodología econométrica basada en modelos dinámicos 
    que utiliza datos de series temporales. La metodología utilizada en los modelos ARIMA 
          fue inicialmente descrita por Box y Jenkins (1970) en su libro: Análisis de series temporales. 
          Predicción y control (Time Series Análisis: Forecasting and Control).",
          
          "A continuación se muestra un pronóstico, usando un modelo ARIMA convencional, y un modelo ARFIMA que
          asume que las series consideradas tienen memoria larga.", 
          sep = "\n" )
  })
  
  #generamos la predicción ARIMA/ARFIMA dinámica (update para plotly)
  output$dy_arima <-renderPlotly({
    data <- datasetInput()
    selseries <- data[,input$seriesforecast]
    don00 <- xts(x = selseries, order.by = as.Date(rownames(data)))
    st <- format(as.Date(start(don00), format="%d/%m/%Y"),"%Y")
    freq <- 12/elapsed_months(time(don00)[2],time(don00)[1])
    fit1 <- auto.arima(ts(don00, start= st, frequency = freq ))
    fit2 <- arfima(ts(don00, start= st, frequency = freq ))
    h <- fcperiodInput()
    fc1 <- forecast(fit1, h)
    fc2 <- forecast(fit2, h)
    plot1 <- plot_forecast(fc1, color = "blue") %>%
      layout(
        plot_bgcolor='transparent',
        yaxis = list(gridcolor= "#AAAAAA"),
        xaxis = list(gridcolor= "#AAAAAA"),
        height = 550) %>%       
      layout(paper_bgcolor='transparent')
    plot2 <- plot_forecast(fc2, color = "red") %>%
      layout(title = paste("Pronóstico ARIMA/ARFIMA de", input$seriesforecast, sep = " "),
             plot_bgcolor='transparent',
             yaxis = list(gridcolor= "#AAAAAA"),
             xaxis = list(gridcolor= "#AAAAAA"),
             height = 550) %>%       
      layout(paper_bgcolor='transparent')
    subplot(plot1, plot2, nrows = 2, shareX = TRUE)
  })
  
  #descomposición de la serie analizada (23-01-21)
  output$tsdecomp <-renderPlotly({
    data <- datasetInput()
    selseries <- data[,input$seriesforecast]
    don00 <- xts(x = selseries, order.by = as.Date(rownames(data)))
    st <- format(as.Date(start(don00), format="%d/%m/%Y"),"%Y")
    freq <- 12/elapsed_months(time(don00)[2],time(don00)[1])
    ts_decompose(ts(don00, start= st, frequency = freq )) %>%
      layout(title = paste("Descomposición de la serie", input$seriesforecast, sep = " "),
             plot_bgcolor='transparent',
             yaxis = list(gridcolor= "#AAAAAA"),
             xaxis = list(gridcolor= "#AAAAAA")) %>%       
      layout(paper_bgcolor='transparent')
  })   
  #autocorrelaciones de la serie (23-01-21)
  output$tslag <-renderPlotly({
    data <- datasetInput()
    selseries <- data[,input$seriesforecast]
    don00 <- xts(x = selseries, order.by = as.Date(rownames(data)))
    st <- format(as.Date(start(don00), format="%d/%m/%Y"),"%Y")
    freq <- 12/elapsed_months(time(don00)[2],time(don00)[1])
    ts_lags(ts(don00, start= st, frequency = freq )) %>%
      layout(title = paste("Autocorrelaciones de la serie", input$seriesforecast, sep = " "),
             plot_bgcolor='transparent') %>%       
      layout(paper_bgcolor='transparent')
  })  
  
  #generamos el diagrama de dispersión
  output$scatterplot <- renderPlotly({
    data <- datasetInput()
    #names(data) <- abbreviate(names(data), minlength = 8)
    df <-data[,c(input$corr1, input$corr2)]
    plot_ly(df, x =df[,1], y = df[,2], type = "scatter", mode = "markers")
  })
  
  #correlaciones de la base de datos
  output$corr <- renderPlot({
    data <- datasetInput()
    names(data) <- abbreviate(names(data), minlength = 8)
    corrdata <- cor(na.omit(data))
    fig <- corrplot.mixed(corrdata, mar=c(1,1,1,1), tl.pos = "lt" ) 
    
    
  })
  
  #output para descarga de base de datos
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataset, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = TRUE)
    }
  )
  observeEvent(input$updateData, {
    #source("PREPROCESSING/downloader.R", local = TRUE)
  })
  
}