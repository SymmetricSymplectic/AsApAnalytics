

ind_choices <- c("Balanza Comercial" = "1",
                 "Establecimientos Comerciales" = "2",
                 "Indicador Global de Actividad Económica (Original)" = "3",
                 "Indicador Global de Actividad Económica (Desestacionalizado)" = "4",
                 #"Índice Mensual de Actividad Industrial (Original)"= "5",
                 #"Índice Mensual de Actividad Industrial (Desestacionalizado)"= "6",
                 "Indicador Mensual de Consumo Privado en el Mercado Interior (Original)" = "5",
                 "Indicador Mensual de Consumo Privado en el Mercado Interior (Desestacionalizado)" = "6",
                 "Indice de Confianza del Consumidor" = "7",
                 "Índice Nacional de Precios al Consumidor (Mensual)" = "8",
                 "Índice Nacional de Precios al Consumidor (Quincenal)" = "9",
                 "Inflación (Mensual)" = "10",
                 "Inflación (Mensual, Interanual)" = "11",
                 "Inflación (Anual acumulada)" = "12",
                 "Inflación (Quincenal)" = "13",
                 #"Inversión Fija Bruta (Original)" = "12",
                 #"Inversión Fija Bruta (Desestacionalizada)" = "13",
                 "Producto Interno Bruto (a precios de 2013)" = "14",
                 "Reservas Internacionales (Mensual)" = "15",
                 "Reservas Internacionales (Semanal)"= "16",
                 "Remesas" = "17",
                 "Sistema de Indicadores Compuestos" = "18",
                 "Tasa de Desocupación" = "19",
                 "Valor de la construcción" = "20",
                 "Vehículos Automotores" = "21",
                 #fin choices mex
                 "Business Sales and Inventories" = "22",
                  "University of Michigan: Surveys of Consumers" = "23",
                  "Construction Spending" = "24",
                 "Consumer Credit" = "25",
                 #"Annual GDP - Index (2012=100)" = "30",
                 "GDP - Quarterly, Seasonally Adjusted" = "26",
                 "Consumer Price Index - 1982-1984=100" = "27",
                 "Producer Price Index - Index Dec 1984=100"= "28",
                 "Manufacturers' New Orders: Durable Goods -Millions of Dollars" = "29",
                 "Unemployment" = "30",
                 "Unemployment claims" = "31",
                 "Personal Income and Consumption" = "32",
                 "Wholesale Trade" = "33",
                 "Retail" = "34",
                 "Advance Retail" = "35",
                 "Car Sales" = "36",
                 "Consumer Price Indexes - International" = "37",
                 #"Import/Export Price Indexes" = "43",
                 "ISM Manufacturero" = "38",
                 "ISM Servicios" = "39",
                 "Housing Starts" = "40",
                 "Building Permits" = "41",
                 #"Energy Commodities" = "46",
                 "Emisoras BMV" = "42",
                 "Divisas" = "43",
                 "Emisoras BMV en USD" = "44",
                 "Emisoras USA" = "45",
                 "Emisoras USA en MXN" = "46",
                 "Indices Bursatiles" = "47",
                 "Tasa Forward promedio USDMXN, Swaps Cambiarios" = "48",
                 "Tasa Forward promedio USDMXN" = "49",
                 "Tasa Forward promedio EURMXN, Swaps Cambiarios" = "50",
                 "Tasa Forward promedio EURMXN" = "51",
                 #"USD Interest Rate Swap Rate" = "56",
                 #"US Treasury Rates" = "57",
                 #"Mexican Government Bond Yields"  = "58",
                 "Tasa LIBOR (USD)" = "52",
                 #"Henry Hub Natural Gas Futures (3y)" = "57",
                 #emisoras
                 "Grupo Pochteca" = "53"
                 #"Grupo Industrial Saltillo"  = "58",
                 #"Corporacion Moctezuma"  = "59"
                 
                 )

rate_choices <- c(
  "Tasa Forward promedio USDMXN, Swaps Cambiarios" = "1",
  "Tasa Forward promedio USDMXN" = "2",
  "Tasa Forward promedio EURMXN, Swaps Cambiarios" = "3",
  "Tasa Forward promedio EURMXN" = "4",
  #"USD Interest Rate Swaps" = "5",
  #"US Treasury Rates" = "6",
  #"Mexican Government Bond Yields"  = "7",
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
                        actionButton("refresh", "Actualizar BDD"),
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

