



#definimos servidor para graficar las series de tiempo
server <- function(input, output, session){
  # call the server part
  # check_credentials returns a function to authenticate users
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials)
  )
  
  output$auth_output <- renderPrint({
    reactiveValuesToList(res_auth)
  })
  
  # your classic server logic
  #input condicional: serie de datos a analizar, permite combinar hasta 5 bases
  datasetInput <- reactive({
    if (length(input$dataset)==2){
      data <- merge(database[[as.numeric(input$dataset[1])]],
                      database[[as.numeric(input$dataset[2])]],
                      by = 0    )
      rownames(data) <- data[,1]
      data <- data[,-1, drop = FALSE]
      data
    } else if (length(input$dataset)==3){
      data <- merge(database[[as.numeric(input$dataset[1])]],
                    database[[as.numeric(input$dataset[2])]],
                    by = 0    )
      rownames(data) <- data[,1]
      data <- data[,-1, drop = FALSE]
      data <- merge(database[[as.numeric(input$dataset[3])]],
                    data,
                    by= 0)
      rownames(data) <- data[,1]
      data <- data[,-1, drop = FALSE]
      data
    }else if (length(input$dataset)==4){
      data <- merge(database[[as.numeric(input$dataset[1])]],
                    database[[as.numeric(input$dataset[2])]],
                    by = 0    )
      rownames(data) <- data[,1]
      data <- data[,-1, drop = FALSE]
      data <- merge(database[[as.numeric(input$dataset[3])]],
                    data,
                    by= 0)
      rownames(data) <- data[,1]
      data <- data[,-1, drop = FALSE]
      data <- merge(database[[as.numeric(input$dataset[4])]],
                    data,
                    by= 0)
      rownames(data) <- data[,1]
      data <- data[,-1, drop = FALSE]
      data
    }else if (length(input$dataset)==5){
      data <- merge(database[[as.numeric(input$dataset[1])]],
                    database[[as.numeric(input$dataset[2])]],
                    by = 0    )
      rownames(data) <- data[,1]
      data <- data[,-1]
      data <- merge(database[[as.numeric(input$dataset[3])]],
                    data,
                    by= 0)
      rownames(data) <- data[,1]
      data <- data[,-1]
      data <- merge(database[[as.numeric(input$dataset[4])]],
                    data,
                    by= 0)
      rownames(data) <- data[,1]
      data <- data[,-1]
      data <- merge(database[[as.numeric(input$dataset[5])]],
                    data,
                    by= 0)
      rownames(data) <- data[,1]
      data <- data[,-1]
      data
    }else  {
      data <-data.frame(database[[as.numeric(input$dataset)]])
      data
    }
    data <- data[order(as.Date(rownames(data), format="%d/%m/%Y")),]
    

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
    selectizeInput("series", "Series a mostrar", names(merged_data()),
                      multiple = TRUE
    )
  })
  #crear las listas de las series dinámicamente (pronóstico)
  output$selectforecast <- renderUI({
    selectInput("seriesforecast", "Escoja una serie para pronóstico", choices = names(merged_data()))
  })
  #crear listas dinámicas (correlación)
  output$seriescorr1 <- renderUI({
    selectInput("corr1", "Escoja la serie 1 para el análisis de dispersión", choices= names(merged_data()))
  })  
  output$seriescorr2 <- renderUI({
    selectInput("corr2", "Escoja la serie 2 para el análisis de dispersión", choices= names(merged_data()))
  })     
  #linear model input
  lmInput <- reactive({
    data <- na.omit(merged_data())
    data <- data[order(as.Date(rownames(data), format="%d/%m/%Y")),]
    df <-na.omit(data[,c(input$corr1, input$corr2)])
    colnames(df) <- c(input$corr1, input$corr2)
    lm_fit <-lm(formula = df[,2]~df[,1], data=df)
    lm_fit
  })
  
  
  
  #generamos la gráfica de las series principales
  output$plotly1<- renderPlotly({
    req(input$series)
    data <- merged_data()
    selseries <- data[,input$series]
    names(selseries) <- abbreviate(names(selseries), minlength = 30)
    don <- xts(x = selseries, order.by = as.Date(rownames(data)))
    setbasis <-switch(input$setbasis,
                      def = don,
                      indexed = baseperiod_function(don, input$baseyear)
      
    )
    varmen <-pch(setbasis)
    varan <- pch(setbasis, lag = 12)
    seriestype <- switch(input$sertype,
                         princ=setbasis,
                         varmensual = varmen,
                         varanual = varan
    )
    
    equis <- rownames(data)
    ts_plot(seriestype, 
            title = paste(input$series[1]),
            Xtitle = "Fecha",
            Xgrid = TRUE,
            Ygrid = TRUE) %>%
      layout(plot_bgcolor='transparent',
             yaxis = list(gridcolor= "#AAAAAA", fixedrange = FALSE, tickformat = ",.2r" ),
             xaxis = list(gridcolor= "#AAAAAA", ticktext = equis
                          #,rangeslider = list(type = "date")
             )) %>% 
      layout(legend = list(x = 0.05, y = 0.95)) %>%
      #layout(hovermode = "x unified") %>%
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
      #show recessions
      layout(shapes=list(
        list(type = "rect",
             fillcolor = "blue", line = list(color = "blue"), opacity = 0.15,
             x0 = "2001-03-01", x1 = "2001-11-01", xref = "x",
             y0 = 0, y1 = 1, yref = "paper"),
        list(type = "rect",
             fillcolor = "blue", line = list(color = "blue"), opacity = 0.15,
             x0 = "2007-12-01", x1 = "2009-06-01", xref = "x",
             y0 = 0, y1 = 1, yref = "paper"),
        list(type = "rect",
             fillcolor = "blue", line = list(color = "blue"), opacity = 0.15,
             x0 = "2020-02-01", x1 = "2021-07-01", xref = "x",
             y0 = 0, y1 = 1, yref = "paper")
        ))%>%
      plotly::config(displaylogo = FALSE)
    
    #will also accept paper_bgcolor='black' or paper_bgcolor='transparent'
  })
  
  #texto que describe la serie Inegi elegida
  output$series_descrip <- renderDataTable({
    meta_data[,-1]
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
    data <- na.omit(merged_data())
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
        xaxis = list(gridcolor= "#AAAAAA")
        ) %>%       
      layout(paper_bgcolor='transparent')
    plot2 <- plot_forecast(fc2, color = "red") %>%
      layout(title = paste("Pronóstico ARIMA/ARFIMA de", input$seriesforecast, sep = " "),
             plot_bgcolor='transparent',
             yaxis = list(gridcolor= "#AAAAAA"),
             xaxis = list(gridcolor= "#AAAAAA")
             ) %>%       
      layout(paper_bgcolor='transparent')
    subplot(plot1, plot2, nrows = 2, shareX = TRUE)
  })
  
  #descomposición de la serie analizada (23-01-21)
  output$tsdecomp <-renderPlotly({
    data <- na.omit(merged_data())
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
    data <- na.omit(merged_data())
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
    data <- na.omit(merged_data())
    df <-na.omit(data[,c(input$corr1, input$corr2)])
    model <- lmInput()
    plot_ly(df, x =df[,1], y = df[,2], type = "scatter", mode = "markers")%>%
      add_lines(x = ~df[,1], y = fitted(model))%>%
      add_ribbons(data = broom::augment(model,se_fit = TRUE),
                  ymin = ~.fitted - 1.96 * .se.fit,
                  ymax = ~.fitted + 1.96 * .se.fit,
                  line = list(color = 'rgba(7, 164, 181, 0.05)'),
                  fillcolor = 'rgba(7, 164, 181, 0.2)',
                  name = '95% ribbon')%>%
      layout(showlegend = F)%>%
      layout(xaxis = list(title=  paste(input$corr1)), yaxis=list(title= paste(input$corr2)) )%>%
      layout(plot_bgcolor='transparent') %>% 
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
  })
  
  #info del ajuste lineal usando sjPlot
  output$lm_info <- renderUI({
    HTML(tab_model(lmInput(), title=paste("Ajuste Lineal de ",
                                          input$corr2, "vs ", input$corr1))$knitr)
  })
  
  #ecuacion ajuste lineal
  output$lm_ec <- renderUI({
    
  })
  
  #correlaciones de la base de datos
  output$corr <- renderPlot({
    data <- na.omit(merged_data())
    data <- data[order(as.Date(rownames(data), format="%d/%m/%Y")),]
    names(data) <- abbreviate(names(data), minlength = 8)
    corrdata <- cor(na.omit(data))
    fig <- corrplot.mixed(corrdata, mar=c(1,1,1,1), tl.pos = "lt" ) 
    
    
  })
  
  
  #rolling correlations
  output$rollcorr <- renderPlotly({
    data <- na.omit(merged_data())
    data <- data[order(as.Date(rownames(data), format="%d/%m/%Y")),]
    df <-xts(data[,c(input$corr1, input$corr2)], order.by = as.Date(rownames(data)))
    roll <-rollapplyr(df, width=input$rollcorrperiod, function(x) cor(x[,1],x[,2]), by.column=FALSE)
    ts_plot(roll,
            title = paste("Correlación móvil de ", input$corr1, " vs ", input$corr2, sep= ""),
            Xtitle = "Fecha",
            Xgrid = TRUE,
            Ygrid = TRUE) %>%
      layout(plot_bgcolor='transparent',
             yaxis = list(gridcolor= "#AAAAAA", fixedrange = FALSE, tickformat = ",.2r" ),
             xaxis = list(gridcolor= "#AAAAAA", ticktext = rownames(data)
                          ,rangeslider = list(type = "date")
             )) %>% 
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
      plotly::config(displaylogo = FALSE)
    
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
  
  #data uploading system
  df_products_upload <- reactive({
    inFile <- input$target_upload
    if (is.null(inFile))
      return(NULL)
    df <- read_csv(inFile$datapath)
    #df <- read.csv(inFile$datapath, header = TRUE,sep = input$separator, encoding = "UTF-8")
    df <-data.frame(df)
    rownames(df)<- df[,1]
    data1 <- df[,-1, drop= FALSE]
    if (input$exceldates =="Sí"){
      rownames(df)<-round_date(anydate(dmy(rownames(df))), unit="month")
    }
    if (input$exceldates =="No"){
      rownames(df)<-round_date(anydate(rownames(df)), unit="month")
    }

    return(df)
  })
  
  output$sample_table<- DT::renderDataTable({
    df <- merged_data()
    DT::datatable(df)
  })
  
  #combinar datos con los datos del usuario
  merged_data<-eventReactive(input$update,{
    data2 <-datasetInput()
    data1 <-df_products_upload()
    data3 <-priceInput()
    if (is.null(data1)){
      if (is.null(data3))
        return(data2)
      datam <-merge(data3,data2, by = 0, all=TRUE)
      rownames(datam) <-datam[,1]
      datam <- datam[,-1]
      return(datam)}
    datam2 <- merge(data1,data2, by = 0, all=TRUE)
    #datam <- na.approx(datam)
    rownames(datam2) <-datam2[,1]
    datam2 <- datam2[,-1]
    if(is.null(data3)){
      return(datam2)}
    datam3 <-merge(data3,datam2, by = 0, all=TRUE)
    rownames(datam3) <-datam3[,1]
    datam3 <- datam3[,-1]
    return(datam3)
  })
  #end data uploading
  
  #bajar precio de instrumento en yfinance
  priceInput <- reactive({
    as.data.frame(getSymbols(input$symb, src = "yahoo",
               from = input$ydates[1],
               to = input$ydates[2],
               auto.assign = FALSE))
  })
  
  
}#server end bracket