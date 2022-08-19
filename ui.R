

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
                 #"Annual GDP - Index (2012=100)" = "30",
                 "GDP - Quarterly, Seasonally Adjusted" = "30",
                 "Consumer Price Index - 1982-1984=100" = "31",
                 "Producer Price Index - Index Dec 1984=100"= "32",
                 "Manufacturers' New Orders: Durable Goods -Millions of Dollars" = "33",
                 "Unemployment" = "34",
                 "Unemployment claims" = "35",
                 "Personal Income and Consumption" = "36",
                 "Wholesale Trade" = "37",
                 "Retail" = "38",
                 "Advance Retail" = "39",
                 "Car Sales" = "40",
                 "Consumer Price Indexes - International" = "41",
                 #"Import/Export Price Indexes" = "43",
                 "ISM Manufacturero" = "42",
                 "ISM Servicios" = "43",
                 "Housing Starts" = "44",
                 "Building Permits" = "45",
                 #"Energy Commodities" = "46",
                 "Emisoras BMV" = "46",
                 "Divisas" = "47",
                 "Emisoras BMV en USD" = "48",
                 "Emisoras USA" = "49",
                 "Emisoras USA en MXN" = "50",
                 "Indices Bursatiles" = "51",
                 "Tasa Forward promedio USDMXN, Swaps Cambiarios" = "52",
                 "Tasa Forward promedio USDMXN" = "53",
                 "USD Interest Rate Swap Rate" = "54",
                 "US Treasury Rates" = "55",
                 "Mexican Government Bond Yields"  = "56",
                 "Tasa LIBOR (USD)" = "57",
                 "Natural Gas Futures (3y)" = "58"
                 )

rate_choices <- c(
  "Forward promedio USDMXN, Swaps Cambiarios" = "1",
  "USD Interest Rate Swaps" = "2",
  "US Treasury Rates" = "3",
  "Mexican Government Bond Yields"  = "4",
  "Tasa LIBOR (USD)" = "5"
  
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
                        actionButton("update", "Crear tabla"),
                        helpText("El botón 'Crear tabla' permite acceder a la tabla de datos del
                                  indicador en la base de datos, 
                                 así como combinarla con datos proporcionados
                                 por el usuario, y con precios OHLC de mercado en una misma tabla"),
                        #input: seleccionar si mostrar el logotipo asapa
                        checkboxInput("show_logo", "Mostrar Logotipo AsApA",
                                     TRUE),
                        #sidebars condicionales dependiendo de qué tabset selecciones
                        conditionalPanel(condition="input.tabselected==1",
                                         #input: seleccionar series para gráficas principales (dinámicas)
                                         uiOutput("selectseries"),
                                         #input: seleccionar instrumento
                                         
                                         textInput("symb", "Seleccione un instrumento o indicador de otra fuente para agregarlo a la visualización"),
                                         radioButtons("quotesource", "Fuente para la cotización:",
                                                      c("Investing.com" = "Investing", "Yahoo Finance" = "yahoo", "FRED"= "FRED"
                                                        )),
                                         helpText("Utilizar la clave del proveedor de datos"),
                                         dateRangeInput("ydates",
                                                        "Intervalo de fechas para el instrumento",
                                                        start = "2017-01-01",
                                                        end = as.character(Sys.Date())),
                                         #input: seleccionar serie vs var porcentual vs annualizar                 
                                         radioButtons("sertype", "Tipo de serie a mostrar:",
                                                      c("Principal" = "princ", "Variación Porcentual" = "varpct", 
                                                        "Anualizar" = "annualize")),
                                         #input: num de periodos para variaciones
                                         numericInput("periods", "Numero de Periodos para la Variacion:", 1, min = 1, max = 10000),
                                         #input: num de periodos para variaciones
                                         numericInput("periodan", "Numero de Periodos para Anualizar:", 1, min = 1, max = 10000),
                                         #input: seleccionar si usar el primer año común como año base
                                         radioButtons("setbasis", "Convertir a índice con un año base",
                                                      c("No" = "def", "Sí" = "indexed")),
                                         #input: seleccionar año base para indexar
                                         airYearpickerInput(
                                           inputId = "baseyear",
                                           label= "Seleccione el año base para el índice",
                                           value = "2000"
                                         ),
                                         #input: mostrar recesiones
                                         checkboxInput("show_recessions", "Mostrar Recesiones (2008, 2020)",
                                                       FALSE),
                                         #Selector for file upload
                                         fileInput('target_upload', 'Seleccione archivo para subir (CSV UTF=8)',
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
                                         numericInput("fcperiod", "Numero de Periodos a Pronosticar:", 1, min = 1, max = 48),
                                         
                        ), #fin del tabset condicional para pronóstico
                        conditionalPanel(condition="input.tabselected==3",
                                         uiOutput("seriescorr1"),
                                         uiOutput("seriescorr2"),
                                         radioButtons("regperiod", "Series a correlacionar:",
                                                      c("Original" = "orig", "LogRendimientos" = "LogRet", "Variaciones" = "Ret")),
                                         numericInput("rollcorrperiod", "Número de periodos para la correlación móvil",
                                                      1, min = 1, max = 48)
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
                                             plotOutput("lm_qq"),
                                             br(),
                                             plotOutput("lm_pp"),
                                             br(),
                                             plotOutput("lm_density"),
                                             br(),
                                             uiOutput("lm_info"),
                                             br(),
                                             plotlyOutput("rollcorr", height = 500),
                                             br(),
                                             plotOutput("corr", height = 1200)
                                             
                                    ),
                                    id = "tabselected" #para cambiar el sidebar dependiendo del tab
                        )
                      )
                      
                      
             ), #fin tabpanel,
             tabPanel("Curvas de tasas",
                      #sidebar para inputs
                      sidebarPanel(
                        
                        
                        #input: seleccionar tasas
                        selectizeInput("termsdata", "Seleccione las tasas",
                                       choices = rate_choices, selected = "1", multiple = TRUE,
                                       options = list(maxItems = 5)
                        ),
                        actionButton("update1", "Mostrar tasas"),
                        uiOutput("selectrates")),
                      mainPanel(
                        plotlyOutput("termstructure"),
                        dataTableOutput("ratestable")
                      )),
             #fin tabpanel tasas
             tabPanel("Buscador de noticias",
                      #sidebar para inputs
                      sidebarPanel(width = 2,
                        
                        
                        #input: buscador
                        textInput("search_news", "Busqueda de noticias"),
                        #api is set from eviron
                        actionButton("update2", "Buscar"),
                        br()),
                      mainPanel(width = 12,
                        dataTableOutput("news")
                      )),#fin tabpanel noticias
             
             tabPanel("Información general de la base de datos",
                      mainPanel(
                        dataTableOutput("series_descrip"),
                        br(),
                        actionButton("updateData", "Actualizar Bases de Datos")
                                     
                      ))

  )#fin navbars
)

# Wrap your UI with secure_app
ui <- secure_app(ui,
                 language = "es"
)

