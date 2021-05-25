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

#logotipos y cosas gráficas extras
asapa <- png::readPNG("www/logotipo-asapa.png")
asapa_black <-png::readPNG("www/logotipo-asapa-min-black.png")
asapa_logo <- rasterGrob(asapa, x = .15, y = .15, height = .15, width = .15,
                         interpolate=TRUE)
asapa_logo_black <- rasterGrob(asapa_black, x = .15, y = .15, height = .15, width = .15,
                               interpolate=TRUE)
back_image <- png::readPNG("www/asapa_back.png")
#config del tema de ggplot2
#escala del texto en las gráficas de ggplot2
theme_set(theme_linedraw(base_size=19))

mex_choices <- c("Balanza Comercial",
                 "Establecimientos Comerciales",
                 "Indicador Global de Actividad Económica (Original)",
                 "Indicador Global de Actividad Económica (Desestacionalizado)",
                 "Índice Mensual de Actividad Industrial (Original)",
                 "Índice Mensual de Actividad Industrial (Desestacionalizado)",
                 "Indicador Mensual de Consumo Privado en el Mercado Interior (Original)",
                 "Indicador Mensual de Consumo Privado en el Mercado Interior (Desestacionalizado)",
                 "Indicador de Confianza del Consumidor",
                 "Índice Nacional de Precios al Consumidor (Mensual)",
                 "Índice Nacional de Precios al Consumidor (Quincenal)",
                 "Inflación (Mensual)",
                 "Inflación (Mensual, Interanual)",
                 "Inflación (Anual acumulada)",
                 "Inflación (Quincenal)",
                 "Inversión Fija Bruta (Original)",
                 "Inversión Fija Bruta (Desestacionalizada)",
                 "Producto Interno Bruto (a precios de 2013)",
                 "Reservas Internacionales (Mensual)",
                 "Reservas Internacionales (Semanal)",
                 "Remesas",
                 "Sistema de Indicadores Compuestos",
                 "Tasa de Desocupación",
                 "Valor de la construcción",
                 "Vehículos Automotores")


#definimos ui
ui <-fluidPage(
  useShinyjs(),
  theme = shinytheme("cerulean"),
  titlePanel(title ="AsApAnalytics"),
  #grid de logotipo de asapa en background
  #setBackgroundImage(src= "asapa_back.png"),
  
  navbarPage("Indicadores",
             tabPanel("México",
                      #layout de sidebars
                      #sidebar para inputs
                      sidebarPanel(
                        
                        #input: seleccionar indicador
                        selectInput("dataset", "Seleccione el indicador deseado",
                                    choices = mex_choices
                        ),
                        
                        #sidebars condicionales dependiendo de qué tabset selecciones
                        conditionalPanel(condition="input.tabselected==1",
                                         #input: seleccionar serie vs varmensual vs varanual                 
                                         radioButtons("sertype", "Tipo de serie a mostrar:",
                                                      c("Principal" = "princ", "Variación Periodo a Periodo" = "varmensual", "Variación a 12 periodos"= "varanual")),
                                         #input: seleccionar series para gráficas principales (dinámicas)
                                         uiOutput("selectseries"),
                        ),#fin del tabset condicional para la serie principal
                        
                        conditionalPanel(condition="input.tabselected==2",
                                         #input: seleccionar serie para pronóstico
                                         uiOutput("selectforecast"),
                                         selectInput("fcperiod", "Seleccione el número de periodos a pronósticar",
                                                     choices =c("6","12","24"))
                        ), #fin del tabset condicional para pronóstico
                        conditionalPanel(condition="input.tabselected==3",
                                         uiOutput("seriescorr1"),
                                         uiOutput("seriescorr2")
                        ),
                        # Input: seleccionar datos a descargar
                        # botón de descarga de los datos
                        downloadButton("downloadData", "Descargar Datos"),
                        actionButton("updateData", "Actualizar Bases de Datos"),
                      ),
                      
                      #panel principal para mostrar outputs
                      mainPanel(
                        #output: tabset
                        #22-10-21 cambio de output de dygraph a plotly para TSstudio, comment las estáticas por obsoletas
                        tabsetPanel(type = "tabs",
                                    tabPanel("Gráfica principal", value=1,
                                             plotlyOutput("plotly1", height=500),
                                             br(),
                                             br(),
                                             br(),
                                             br(),
                                             br(),
                                             br(),
                                             br(),
                                             br(),
                                             textOutput("series_descrip"),
                                             br(),
                                             dataTableOutput("tabla")
                                    ),
                                    tabPanel("Pronóstico y Análisis", value = 2,
                                             br(),
                                             textOutput("forecast_descrip"),
                                             br(),
                                             plotlyOutput("dy_arima"),
                                             br(),
                                             br(),
                                             br(),
                                             br(),
                                             br(),
                                             br(),
                                             br(),
                                             br(),
                                             plotlyOutput("tsdecomp"),
                                             br(),
                                             plotlyOutput("tslag"),
                                             #verbatimTextOutput("arimafc"),
                                             #dygraphOutput("dy_arfima"),
                                             #plotOutput("arfimaplot"),
                                             br()
                                             #verbatimTextOutput("arfimafc")
                                    ),
                                    tabPanel("Análisis Comparativo de Correlación", value = 3,
                                             plotlyOutput("scatterplot", height=500),
                                             br(),
                                             plotOutput("corr", height = 900)
                                    ),
                                    id = "tabselected" #para cambiar el sidebar dependiendo del tab
                        )
                      )
                      
                      
             ),
             tabPanel("Estados Unidos")
             
  )
)