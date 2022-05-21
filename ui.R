

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
                 "GDP - Quarterly, Seasonally Adjusted" = "31",
                 "Consumer Price Index - 1982-1984=100" = "32",
                 "Producer Price Index - Index Dec 1984=100"= "33",
                 "Manufacturers' New Orders: Durable Goods -Millions of Dollars" = "34",
                 "Unemployment" = "35",
                 "Unemployment claims" = "36",
                 "Personal Income and Consumption" = "37",
                 "Wholesale Trade" = "38",
                 "Retail" = "39",
                 "Advance Retail" = 40,
                 "Car Sales" = "41",
                 "Consumer Price Indexes - International" = "42",
                 "Import/Export Price Indexes" = "43",
                 "ISM Manufacturero" = "44",
                 "ISM Servicios" = "45",
                 "Housing Starts" = "46",
                 "Building Permits" = "47",
                 "Energy Commodities" = "48",
                 "Emisoras BMV" = "49",
                 "Divisas" = "50",
                 "Emisoras BMV en USD" = "51",
                 "Emisoras USA" = "52",
                 "Emisoras USA en MXN" = "53",
                 "Indices Bursatiles" = "54",
                 "Forward promedio USDMXN, Swaps Cambiarios" = "55",
                 "USD Interest Rate Swaps" = "56",
                 "US Treasury Rates" = "57"
                 )

rate_choices <- c(
  "Forward promedio USDMXN, Swaps Cambiarios" = "1",
  "USD Interest Rate Swaps" = "2",
  "US Treasury Rates" = "3"
  
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
                                 así como combinar tal tabla con una tabla de datos proporcionada
                                 por el usuario, y la tabla de precios de mercado en una misma tabla"),
                        
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
                                         #input: seleccionar serie vs var porcentual vs annualizar                 
                                         radioButtons("sertype", "Tipo de serie a mostrar:",
                                                      c("Principal" = "princ", "Variación Porcentual" = "varpct", 
                                                        "Anualizar" = "annualize")),
                                         #input: num de periodos para variaciones
                                         numericInput("periods", "Numero de Periodos para la Variacion:", 1, min = 1, max = 10000),
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
                        plotlyOutput("termstructure")
                      )),
             #fin tabpanel tasas
             tabPanel("Buscador de noticias",
                      #sidebar para inputs
                      sidebarPanel(
                        
                        
                        #input: buscador
                        searchInput(
                          inputId = "newssearch", label = "Enter your text",
                          placeholder = "BMV",
                          btnSearch = icon("search"),
                          btnReset = icon("remove"),
                          width = "450px"
                        ),
                        br(),
                      mainPanel(
                        dataTableOutput("news")
                      ))
                      ),#fin tabpanel noticias
             
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

