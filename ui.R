

ind_choices <- c("Balanza Comercial" = "1",
                 "Establecimientos Comerciales" = "2",
                 "Indicador Global de Actividad Económica (Original)" = "3",
                 "Indicador Global de Actividad Económica (Desestacionalizado)" = "4",
                 "Índice Mensual de Actividad Industrial (Original)"= "5",
                 "Índice Mensual de Actividad Industrial (Desestacionalizado)"= "6",
                 "Indicador Mensual de Consumo Privado en el Mercado Interior (Original)" = "7",
                 "Indicador Mensual de Consumo Privado en el Mercado Interior (Desestacionalizado)" = "8",
                 "Indice de Confianza del Consumidor" = "9",
                 "Índice Nacional de Precios al Consumidor (Mensual)" = "10",
                 "Índice Nacional de Precios al Consumidor (Quincenal)" = "11",
                 "Inflación (Mensual)" = "12",
                 "Inflación (Mensual, Interanual)" = "13",
                 "Inflación (Anual acumulada)" = "14",
                 "Inflación (Quincenal)" = "15",
                 "Inversión Fija Bruta (Original)" = "16",
                 "Inversión Fija Bruta (Desestacionalizada)" = "17",
                 "Producto Interno Bruto (a precios de 2013)" = "18",
                 "Reservas Internacionales (Mensual)" = "19",
                 "Reservas Internacionales (Semanal)"= "20",
                 "Remesas" = "21",
                 "Sistema de Indicadores Compuestos" = "22",
                 "Tasa de Desocupación" = "23",
                 "Valor de la construcción" = "24",
                 "Vehículos Automotores" = "25",
                 #fin choices mex
                 "Business Sales and Inventories" = "26",
                  "University of Michigan: Surveys of Consumers" = "27",
                  "Construction Spending" = "28",
                 "Consumer Credit" = "29",
                 "Annual GDP - Index (2012=100)" = "30",
                 "Annual GDP - Seasonally Adjusted" = "31",
                 "Consumer Price Index - 1982-1984=100" = "32",
                 "Producer Price Index - Index Dec 1984=100"= "33",
                 "Manufacturers' New Orders: Durable Goods -Millions of Dollars" = "34",
                 "Unemployment" = "35",
                 "Unemployment claims" = "36",
                 "Personal Income and Consumption" = "37",
                 "Wholesale Trade" = "38",
                 "Advance Retail" = "39",
                 "Car Sales" = "40"
                 )



#definimos ui
ui <-fluidPage(
  #tags$h2("My secure application"),
  #verbatimTextOutput("auth_output"),
  useShinyjs(),
  theme = shinytheme("cerulean"),
  titlePanel(title ="AsApAnalytics"),
  #grid de logotipo de asapa en background
  #setBackgroundImage(src= "asapa_back.png"),
  
  navbarPage("InfoAsApA Dashboard",
             tabPanel("Indicadores Económicos",
                      #layout de sidebars
                      #sidebar para inputs
                      sidebarPanel(
            
                        
                        #input: seleccionar indicador
                        selectizeInput("dataset", "Seleccione el indicador de la base de datos",
                                    choices = ind_choices, selected = "1", multiple = TRUE,
                                    options = list(maxItems = 5)
                        ),
                        actionButton("update", "Mostrar series"),
                        helpText("El botón 'Mostrar series' permite acceder al indicador en la base de datos, 
                                 así como combinarlo con la base de datos proporcionada con el usuario
                                 y con el precio del instrumento de mercado en una misma tabla"),
                        
                        #sidebars condicionales dependiendo de qué tabset selecciones
                        conditionalPanel(condition="input.tabselected==1",
                                         #input: seleccionar series para gráficas principales (dinámicas)
                                         uiOutput("selectseries"),
                                         #input: seleccionar instrumento
                                         
                                         textInput("symb", "Seleccione un instrumento cotizado para agregarlo a la visualización"),
                                         helpText("Utilizar el ticker de Yahoo Finance"),
                                         dateRangeInput("ydates",
                                                        "Intervalo de fechas para el instrumento",
                                                        start = "2007-01-01",
                                                        end = as.character(Sys.Date())),
                                         #input: seleccionar serie vs varmensual vs varanual                 
                                         radioButtons("sertype", "Tipo de serie a mostrar:",
                                                      c("Principal" = "princ", "Variación Periodo a Periodo" = "varmensual", "Variación a 12 periodos"= "varanual",
                                                        "Variación a 4 periodos"="vartrim")),
                                         #input: seleccionar si usar el primer año común como año base
                                         radioButtons("setbasis", "Convertir a índice con un año base",
                                                      c("No" = "def", "Sí" = "indexed")),
                                         #input: seleccionar año base para indexar
                                         airYearpickerInput(
                                           inputId = "baseyear",
                                           label= "Seleccione el año base para el índice",
                                           value = "2000"
                                         ),
                                         #Selector for file upload
                                         fileInput('target_upload', 'Seleccione archivo para subir',
                                                   accept = c(
                                                     'text/csv',
                                                     'text/comma-separated-values',
                                                     '.csv'
                                                   )),
                                         helpText("Al momento de subir el archivo, es importante que el formato de fechas sea
                                                  dd/mm/yyyy"),
                                         #radioButtons("separator","Separador: ",choices = c(";",",",":"), selected=";",inline=TRUE),
                                         radioButtons("exceldates", "El archivo utiliza fechas de MS Excel", choices = c("Sí", "No"),
                                                      selected ="Sí", inline = TRUE),
                                         helpText("Si el archivo se editó en MS Excel, seleccione esta opción para
                                                  que las fechas de las series se lean correctamente.")
                        ),#fin del tabset condicional para la serie principal
                        
                        conditionalPanel(condition="input.tabselected==2",
                                         #input: seleccionar serie para pronóstico
                                         uiOutput("selectforecast"),
                                         selectInput("fctype", "Seleccione el tipo de modelo para pronosticar",
                                                     choices =c("ARIMA","ETS","ARFIMA")),
                                         selectInput("fcperiod", "Seleccione el número de periodos a pronosticar",
                                                     choices =c("4","6","12","24","48"))
                                         
                        ), #fin del tabset condicional para pronóstico
                        conditionalPanel(condition="input.tabselected==3",
                                         uiOutput("seriescorr1"),
                                         uiOutput("seriescorr2"),
                                         selectInput("rollcorrperiod", "Seleccione el número de periodos para la correlación móvil",
                                                     choices =c("3","6","12","24"))
                        ),
                        # Input: seleccionar datos a descargar
                        # botón de descarga de los datos
                        downloadButton("downloadData", "Descargar Datos"),

                      ),
                      
                      #panel principal para mostrar outputs
                      mainPanel(
                        #output: tabset
                        #22-01-21 cambio de output de dygraph a plotly para TSstudio, comment las estáticas por obsoletas
                        tabsetPanel(type = "tabs",
                                    tabPanel("Visualización general", value=1,
                                             plotlyOutput("plotly1", height=650),
                                             br(),
                                             dataTableOutput("tabla")
                                    ),
                                    tabPanel("Econometría", value = 2,
                                             br(),
                                             textOutput("forecast_descrip"),
                                             br(),
                                             plotlyOutput("dy_arima", height= 750),
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
                                    tabPanel("Diagnósticos de Regresión", value = 3,
                                             plotlyOutput("scatterplot", height=500),
                                             br(),
                                             uiOutput("lm_ec"),
                                             br(),
                                             uiOutput("lm_info"),
                                             br(),
                                             plotlyOutput("rollcorr", height = 500),
                                             br(),
                                             plotOutput("corr", height = 900)
                                             
                                    ),
                                    id = "tabselected" #para cambiar el sidebar dependiendo del tab
                        )
                      )
                      
                      
             ), #fin tabpanel
             #fin tabpanel csv
             tabPanel("Información general de la base de datos",
                      mainPanel(
                        dataTableOutput("series_descrip"),
                        br(),
                        actionButton("updateData", "Actualizar Bases de Datos")
                                     
                      ))

  )#fin navbars
)

# Wrap your UI with secure_app
ui <- secure_app(ui)

