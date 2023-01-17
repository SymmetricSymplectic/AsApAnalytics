



#definimos servidor para graficar las series de tiempo
server <- function(input, output, session){
  # call the server part

  
  #initial db load call
  database <-list()
  for (i in 1:length(tablelist$index)){
    table <- dbReadTable(conn=asapadb_remote, name=paste(tablelist$dbname[i]))
    assign(paste(tablelist$dfname[i]), table )
    database[[i]] <-get(tablelist$dfname[i])
    rm(list=paste(tablelist$dfname[i]))
    rm(table)
  }
  
  termstructure_db <- list()
  for (i in 1:length(rateslist$index)){
    table <- dbReadTable(conn=asapadb_remote, name=paste(rateslist$dbname[i]))
    assign(paste(rateslist$dfname[i]), table )
    termstructure_db[[i]] <-get(rateslist$dfname[i])
    rm(list=paste(rateslist$dfname[i]))
    rm(table)
  }
  #create named vectors for shiny selectizer
  rate_choices <- rateslist$index
  names(rate_choices) <-rateslist$tablename
  
  ind_choices <- tablelist$index
  names(ind_choices) <-tablelist$tablename
  
  
  
  # check_credentials returns a function to authenticate users
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials)
  )
  
  output$auth_output <- renderPrint({
    reactiveValuesToList(res_auth)
  })
  
  #boton para reiniciar app y actualizar series BDD
  observeEvent(input$refresh, {
    refresh()
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
    data <- data[order(as.Date(rownames(data), format="%Y/%m/%d")),]
    

  })
  
  #input condicional: estructura de tasas a analizar, permite combinar hasta 5 bases
  termsdataInput <- reactive({
    if (length(input$termsdata)==2){
      data <- merge(termstructure_db[[as.numeric(input$termsdata[1])]],
                    termstructure_db[[as.numeric(input$termsdata[2])]],
                    by = 0    )
      rownames(data) <- data[,1]
      data <- data[,-1, drop = FALSE]
      data
    } else if (length(input$termsdata)==3){
      data <- merge(termstructure_db[[as.numeric(input$termsdata[1])]],
                    termstructure_db[[as.numeric(input$termsdata[2])]],
                    by = 0    )
      rownames(data) <- data[,1]
      data <- data[,-1, drop = FALSE]
      data <- merge(termstructure_db[[as.numeric(input$termsdata[3])]],
                    data,
                    by= 0)
      rownames(data) <- data[,1]
      data <- data[,-1, drop = FALSE]
      data
    }else if (length(input$termsdata)==4){
      data <- merge(termstructure_db[[as.numeric(input$termsdata[1])]],
                    termstructure_db[[as.numeric(input$termsdata[2])]],
                    by = 0    )
      rownames(data) <- data[,1]
      data <- data[,-1, drop = FALSE]
      data <- merge(termstructure_db[[as.numeric(input$termsdata[3])]],
                    data,
                    by= 0)
      rownames(data) <- data[,1]
      data <- data[,-1, drop = FALSE]
      data <- merge(termstructure_db[[as.numeric(input$termsdata[4])]],
                    data,
                    by= 0)
      rownames(data) <- data[,1]
      data <- data[,-1, drop = FALSE]
      data
    }else if (length(input$termsdata)==5){
      data <- merge(termstructure_db[[as.numeric(input$termsdata[1])]],
                    termstructure_db[[as.numeric(input$termsdata[2])]],
                    by = 0    )
      rownames(data) <- data[,1]
      data <- data[,-1]
      data <- merge(termstructure_db[[as.numeric(input$termsdata[3])]],
                    data,
                    by= 0)
      rownames(data) <- data[,1]
      data <- data[,-1]
      data <- merge(termstructure_db[[as.numeric(input$termsdata[4])]],
                    data,
                    by= 0)
      rownames(data) <- data[,1]
      data <- data[,-1]
      data <- merge(termstructure_db[[as.numeric(input$termsdata[5])]],
                    data,
                    by= 0)
      rownames(data) <- data[,1]
      data <- data[,-1]
      data
    }else  {
      data <-data.frame(termstructure_db[[as.numeric(input$termsdata)]])
      data
    }
    data <- data[order(as.Date(rownames(data), format="%d/%m/%Y")),]
    
    
  })
  
  
  #input condicional: periodos a pronosticar
  fcperiodInput <- reactive({
    fcper <- input$fcperiod
    return(fcper)
  })
  

  
  
  
  
  #crear los checkboxes de las series dinámicamente (principal)
  output$selectseries <- renderUI({
    selectizeInput("series", "Series a mostrar", names(merged_data()),
                      multiple = TRUE
    )
  })
  #crear los checkboxes de las estructuras de tasas
  output$selectrates <- renderUI({
    selectizeInput("rates", "tasas a mostrar", rownames(merged_rates()),
                   multiple = TRUE, options = list(maxOptions = 10000)
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
  
  #reactive main table xts transform backend
  data_transform <- reactive({
    req(input$series)
    data <- merged_data()
    selseries <- na.omit(data[,input$series,drop=FALSE])
    don <- xts(x = selseries, order.by = as.Date(rownames(selseries)))
    setbasis <-switch(input$setbasis,
                      def = don,
                      indexed = baseperiod_function(don, input$baseyear)
    )
    varperct <-pch(setbasis, lag = input$periods)
    varann <- annualize(setbasis, lag = input$periods, periods = input$periodan)
    seriestype <- switch(input$sertype,
                         princ=setbasis,
                         varpct = varperct,
                         annualize = varann
    )
    return(seriestype)
  })
  
  
  
  
  #linear model input
  lmInput <- reactive({
    data <- na.omit(merged_data())
    data <- data[order(as.Date(rownames(data), format="%d/%m/%Y")),]
    v1 <-as.numeric(data[,c(input$corr1)])
    v2 <-as.numeric(data[,c(input$corr2)])
    df1 <-na.omit(data.frame(v1, v2))
    df2 <-na.omit(data.frame(c(NA,diff(log(data[,c(input$corr1)]))), c(NA,diff(log(data[,c(input$corr2)])))))
    df3 <-na.omit(data.frame(c(NA,diff(data[,c(input$corr1)])), c(NA,diff(data[,c(input$corr2)]))))
    df <- switch(input$regperiod,
                         orig=df1,
                         LogRet = df2,
                         Ret = df3)
    colnames(df) <- c(input$corr1, input$corr2)
    lm_fit <-lm(formula = df[,2]~df[,1], data=df)
    lm_fit
  })
  
  
  
  #generamos la gráfica de las series principales
  output$plotly1<- renderPlotly({
    seriesselect <- data_transform()
    #p <- seriesselect %>%
     # zoo::fortify.zoo() %>%
     # as_tibble() %>%
     # tidyr::pivot_longer(-Index, names_to = "series", values_to = "values") %>%
     # ggplot(aes(x = Index, y = values, color = series)) + 
    #  geom_point()
    #ggplotly(p)%>%
    ts_plot(seriesselect, 
            title = paste(input$series[1]),
            Xtitle = "Fecha",
            Xgrid = TRUE,
            Ygrid = TRUE) %>%
      layout(plot_bgcolor='transparent',
             yaxis = list(gridcolor= "#AAAAAA", fixedrange = FALSE, tickformat = ",.2f" ),
             xaxis = list(gridcolor= "#AAAAAA" #, ticktext = index(seriesselect)
                          #,rangeslider = list(type = "date")
             )) %>% 
      layout(legend = list(x = 0.05, y = 0.95)) %>%
      #layout(hovermode = "x unified") %>%
      #logotipo Asapa
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
               opacity = 0.1,
               visible = input$show_logo
          ))) %>%
      #show recessions
      layout(
        shapes=list(
        list(type = "rect",
             fillcolor = "blue", line = list(color = "blue"), opacity = 0.15,
             x0 = "2007-12-01", x1 = "2009-06-01", xref = "x",
             y0 = 0, y1 = 1, yref = "paper", visible = input$show_recessions),
        list(type = "rect",
             fillcolor = "blue", line = list(color = "blue"), opacity = 0.15,
             x0 = "2020-02-01", x1 = "2021-12-01", xref = "x",
             y0 = 0, y1 = 1, yref = "paper", visible = input$show_recessions)
        
        ))%>%
      plotly::config(displaylogo = FALSE)
    
    #will also accept paper_bgcolor='black' or paper_bgcolor='transparent'
  })
  
  #texto que describe la serie Inegi elegida
  output$series_descrip <- renderDataTable({
    meta_data[,-1]
  })
  #tabla con los datos de la serie
  output$tabla <- renderDataTable({
    series <-data_transform()
    series %>% fortify.zoo %>% as_tibble 
    })
  
  #texto que describe los modelos arima y arfima
  output$forecast_descrip <- renderText({
    paste("El pronóstico resultante depende del tipo de modelo que se utilice.")
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
    fit3 <- ets(ts(don00, start= st, frequency = freq ))
    h <- fcperiodInput()
    fc1 <- forecast(fit1, h)
    fc2 <- forecast(fit2, h)
    fc3 <- forecast(fit3, h)
    forecast_type <- switch(input$fctype,
                            "ARIMA" = fc1,
                            "ETS" = fc3,
                            "ARFIMA" = fc2
                            )
    plot <- plot_forecast(forecast_type, color = "blue") %>%
      layout(
        plot_bgcolor='transparent',
        yaxis = list(gridcolor= "#AAAAAA"),
        xaxis = list(gridcolor= "#AAAAAA")
        ) %>%
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
               opacity = 0.1,
               visible = input$show_logo
          ))) %>%
      layout(paper_bgcolor='transparent')
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
    data[is.na(data)] <- 0
    df1 <-na.omit(data.frame(data[,c(input$corr1, input$corr2)]))
    df2 <-na.omit(data.frame(c(NA,diff(log(data[,c(input$corr1)]))), c(NA,diff(log(data[,c(input$corr2)])))))
    df3 <-na.omit(data.frame(c(NA,diff(data[,c(input$corr1)])), c(NA,diff(data[,c(input$corr2)]))))
    df <- switch(input$regperiod,
                 orig=df1,
                 LogRet = df2,
                 Ret = df3)
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
               opacity = 0.1,
               visible = input$show_logo
          ))) %>%
      plotly::config(displaylogo = FALSE)
  })
  
  #info del ajuste lineal usando sjPlot
  output$lm_info <- renderUI({
    HTML(tab_model(lmInput(), title=paste("Ajuste Lineal de ",
                                          input$corr2, "vs ", input$corr1))$knitr)
  })
  
  #grafs ajuste lineal
  output$lm_qq <- renderPlot({
    check <- check_normality(lmInput(),panel = FALSE)
    plot(check, type = "qq")
  })
  output$lm_pp <- renderPlot({
    check <- check_normality(lmInput(),panel = FALSE)
    plot(check, type = "pp")
  })
  output$lm_density <- renderPlot({
    check <- check_normality(lmInput(),panel = FALSE)
    plot(check, type = "density")
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
               opacity = 0.1,
               visible = input$show_logo
          ))) %>%
      plotly::config(displaylogo = FALSE)
    
  })
  
  #visor de estructura de tasas
  
  output$termstructure <- renderPlotly({
    req(input$rates)
    data <- merged_rates()
    data$dates <- rownames(data)
    data <- data.table(data)
    data <- melt(data, id.vars = "dates")
    data <- data[which(data$dates==input$rates)]
    data %>% rename(tenor = variable)
    plot_ly(data, x = ~variable, y = ~value,
            split = ~dates,
            type = "scatter", mode = "lines+markers"
            )%>%
      layout(xaxis = list(title="Tenor", 
                          categoryarray = names, categoryorder = "array"))%>%
      layout(title = 'Estructura de Tasas',
             yaxis = list(title= "Valor"))%>%
      
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
               opacity = 0.1,
               visible = input$show_logo
          ))) %>%
      plotly::config(displaylogo = FALSE)
  }) 
  #tabla con los datos de la serie
  output$ratestable <- renderDataTable({
    req(input$rates)
    data <- merged_rates()
    data$dates <- rownames(data)
    data <- data.table(data)
    data <- melt(data, id.vars = "dates")
    data <- data[which(data$dates==input$rates)]
    data%>% fortify.zoo %>% as_tibble %>% rename(tenor = variable)  
  })
  
  
  #output para descarga de base de datos
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataset, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(as.data.frame(data_transform()), file, row.names = TRUE)
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
    df <- df[,-1, drop= FALSE]
    if (input$exceldates =="Sí"){
      rownames(df)<-round_date(anydate(dmy(rownames(df))), unit="month")
    }
    if (input$exceldates =="No"){
      rownames(df)<-round_date(anydate(rownames(df)), unit="month")
    }

    return(df)
  })
  
  
  news_table = eventReactive(input$update2,{
    query <-input$search_news
    newsapi_key(paste(api))
    table <- every_news(q= query, results = 10)
    return(table)
  })
  
  
  #visor de noticias
  output$news<- renderDataTable(
    news_table(), options = list(lengthChange = FALSE)
  )
  
  #combinar datos con los datos del usuario
  merged_data<-eventReactive(input$update,{
    data2 <-datasetInput()
    data1 <-df_products_upload()
    #data1[is.na(data1)] <- 0
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
  
  #combinar tasas
  
  merged_rates<-eventReactive(input$update1,{
    data <-termsdataInput()
    return(data)
  })
  
  
  
  #bajar precio de instrumento en yfinance
  priceInput <- reactive({
    as.data.frame(getSymbols(input$symb, src = input$quotesource,
               from = input$ydates[1],
               to = input$ydates[2],
               auto.assign = FALSE))
  })
  
  
}#server end bracket