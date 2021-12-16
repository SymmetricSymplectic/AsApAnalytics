#USA GENERIC PREPROC

#mtis
mtis_data <- read.csv("DATA/businessSalesInv.csv")
rownames(mtis_data) <- mtis_data[,1]
mtis_data <- mtis_data[,-1]
names(mtis_data) <- c("Total business",
                      "Total Manufacturers",
                      "Retail Trade",
                      "Merchant Wholesalers Sales",
                      "Total business Inventories",
                      "Total Manufacturers Inventories",
                      "Retail Trade",
                      "Merchant Wholesalers Inventories"
) 


#consumer surveys
consurvey_data <- read.csv("DATA/consurvey.csv")
rownames(consurvey_data) <- consurvey_data[,1]
consurvey_data <- consurvey_data[,-1]
names(consurvey_data) <- c("Inflation Expectation",            
                      "Consumer Sentiment")

#construction spending
#conspending <- fredr_release_series(release_id = 229)

conspending_data <- read.csv("DATA/conspending.csv")
rownames(conspending_data) <- conspending_data[,1]
conspending_data <- conspending_data[,-1]
titles <- c(   "Total Public Construction Spending: Residential in the United States",                 
               "Total Public Construction Spending: Office in the United States",                      
               "Total Public Construction Spending: Commercial in the United States",                  
               "Total Public Construction Spending: Health Care in the United States",                 
               "Total Public Construction Spending: Educational in the United States",                 
               "Total Public Construction Spending: Public Safety in the United States",               
               "Total Public Construction Spending: Amusement and Recreation in the United States",    
               "Total Public Construction Spending: Transportation in the United States",              
               "Total Public Construction Spending: Power in the United States",             
               "Total Public Construction Spending: Highway and Street in the United States",          
               "Total Public Construction Spending: Sewage and Waste Disposal in the United States",   
               "Total Public Construction Spending: Water Supply in the United States",                
               "Total Public Construction Spending: Conservation and Development in the United States",
               "Total Public Construction Spending: Nonresidential in the United States",              
               "Total Public Construction Spending: Total Construction in the United States",          
               "Total Construction Spending: Residential in the United States",                        
               "Total Construction Spending: Lodging in the United States",                            
               "Total Construction Spending: Office in the United States",                             
               "Total Construction Spending: Commercial in the United States",                         
               "Total Construction Spending: Health Care in the United States",                        
               "Total Construction Spending: Educational in the United States",                        
               "Total Construction Spending: Religious in the United States",                          
               "Total Construction Spending: Public Safety in the United States",                      
               "Total Construction Spending: Amusement and Recreation in the United States",           
               "Total Construction Spending: Transportation in the United States",                     
               "Total Construction Spending: Communication in the United States",                      
               "Total Construction Spending: Power in the United States",                             
               "Total Construction Spending: Highway and Street in the United States",                 
               "Total Construction Spending: Sewage and Waste Disposal in the United States",          
               "Total Construction Spending: Water Supply in the United States",                       
               "Total Construction Spending: Conservation and Development in the United States",       
               "Total Construction Spending: Manufacturing in the United States",                      
               "Total Construction Spending: Nonresidential in the United States",                     
               "Total Construction Spending: Total Construction in the United States",                 
               "Total Private Construction Spending: Residential in the United States",                
               "Total Private Construction Spending: Lodging in the United States",                    
               "Total Private Construction Spending: Office in the United States",                     
               "Total Private Construction Spending: Commercial in the United States",                 
               "Total Private Construction Spending: Health Care in the United States",                
               "Total Private Construction Spending: Educational in the United States",                
               "Total Private Construction Spending: Religious in the United States",                  
               "Total Private Construction Spending: Amusement and Recreation in the United States",   
               "Total Private Construction Spending: Transportation in the United States",             
               "Total Private Construction Spending: Communication in the United States",              
               "Total Private Construction Spending: Power in the United States",                      
               "Total Private Construction Spending: Manufacturing in the United States",              
               "Total Private Construction Spending: Nonresidential in the United States",             
               "Total Private Construction Spending: Total Construction in the United States",         
               "Total Public Construction Spending: Amusement and Recreation in the United States",    
               "Total Public Construction Spending: Amusement and Recreation in the United States",    
               "Total Public Construction Spending: Conservation and Development in the United States",
               "Total Public Construction Spending: Conservation and Development in the United States",
               "Total Public Construction Spending: Commercial in the United States",                  
               "Total Public Construction Spending: Commercial in the United States",                  
               "Total Public Construction Spending: Educational in the United States",                 
               "Total Public Construction Spending: Educational in the United States",                 
               "Total Public Construction Spending: Health Care in the United States",                 
               "Total Public Construction Spending: Health Care in the United States",                 
               "Total Public Construction Spending: Highway and Street in the United States",          
               "Total Public Construction Spending: Highway and Street in the United States",          
               "Total Public Construction Spending: Nonresidential in the United States",              
               "Total Public Construction Spending: Nonresidential in the United States",              
               "Total Public Construction Spending: Office in the United States",                      
               "Total Public Construction Spending: Office in the United States",                      
               "Total Public Construction Spending: Public Safety in the United States",               
               "Total Public Construction Spending: Public Safety in the United States",               
               "Total Public Construction Spending: Power in the United States",                       
               "Total Public Construction Spending: Power in the United States",                      
               "Total Public Construction Spending: Residential in the United States",                 
               "Total Public Construction Spending: Residential in the United States",                 
               "Total Public Construction Spending: Sewage and Waste Disposal in the United States",   
               "Total Public Construction Spending: Sewage and Waste Disposal in the United States",   
               "Total Public Construction Spending: Transportation in the United States",              
               "Total Public Construction Spending: Transportation in the United States",              
               "Total Public Construction Spending: Water Supply in the United States",              
               "Total Public Construction Spending: Water Supply in the United States",                
               "Total Private Construction Spending: Lodging in the United States",                    
               "Total Private Construction Spending: Lodging in the United States",                    
               "Total Private Construction Spending: Nonresidential in the United States",             
               "Total Private Construction Spending: Nonresidential in the United States",             
               "Total Private Construction Spending: Amusement and Recreation in the United States",   
               "Total Private Construction Spending: Amusement and Recreation in the United States",   
               "Total Private Construction Spending: Communication in the United States",              
               "Total Private Construction Spending: Communication in the United States",              
               "Total Private Construction Spending: Commercial in the United States",                 
               "Total Private Construction Spending: Commercial in the United States",                 
               "Total Private Construction Spending: Educational in the United States",                
               "Total Private Construction Spending: Educational in the United States",                
               "Total Private Construction Spending: Health Care in the United States",                
               "Total Private Construction Spending: Health Care in the United States",                
               "Total Private Construction Spending: Manufacturing in the United States",              
               "Total Private Construction Spending: Manufacturing in the United States",              
               "Total Private Construction Spending: Office in the United States",                    
               "Total Private Construction Spending: Office in the United States",                     
               "Total Private Construction Spending: Power in the United States",                      
               "Total Private Construction Spending: Power in the United States",                      
               "Total Private Construction Spending: Religious in the United States",                  
               "Total Private Construction Spending: Religious in the United States",                  
               "Total Private Construction Spending: Residential in the United States",                
               "Total Private Construction Spending: Residential in the United States",                
               "Total Private Construction Spending: Transportation in the United States",             
               "Total Private Construction Spending: Transportation in the United States",             
               "Total Construction Spending: Amusement and Recreation in the United States",           
               "Total Construction Spending: Amusement and Recreation in the United States",           
               "Total Construction Spending: Conservation and Development in the United States",       
               "Total Construction Spending: Conservation and Development in the United States",       
               "Total Construction Spending: Communication in the United States",                      
               "Total Construction Spending: Communication in the United States",                      
               "Total Construction Spending: Commercial in the United States",                         
               "Total Construction Spending: Commercial in the United States",                         
               "Total Construction Spending: Educational in the United States",                        
               "Total Construction Spending: Educational in the United States",                        
               "Total Construction Spending: Health Care in the United States",                        
               "Total Construction Spending: Health Care in the United States",                        
               "Total Construction Spending: Highway and Street in the United States",                 
               "Total Construction Spending: Highway and Street in the United States",                 
               "Total Construction Spending: Lodging in the United States",                            
               "Total Construction Spending: Lodging in the United States",                            
               "Total Construction Spending: Manufacturing in the United States",                      
               "Total Construction Spending: Manufacturing in the United States",                      
               "Total Construction Spending: Nonresidential in the United States",                     
               "Total Construction Spending: Nonresidential in the United States",                     
               "Total Construction Spending: Office in the United States",                             
               "Total Construction Spending: Office in the United States",                             
               "Total Public Construction Spending: Total Construction in the United States",          
               "Total Public Construction Spending: Total Construction in the United States",          
               "Total Private Construction Spending: Total Construction in the United States",         
               "Total Private Construction Spending: Total Construction in the United States",         
               "Total Construction Spending: Public Safety in the United States",                      
               "Total Construction Spending: Public Safety in the United States",                      
               "Total Construction Spending: Power in the United States",                              
               "Total Construction Spending: Power in the United States",                              
               "Total Construction Spending: Religious in the United States",                          
               "Total Construction Spending: Religious in the United States",                          
               "Total Construction Spending: Residential in the United States",                        
               "Total Construction Spending: Residential in the United States",                        
               "Total Construction Spending: Sewage and Waste Disposal in the United States",          
               "Total Construction Spending: Sewage and Waste Disposal in the United States",          
               "Total Construction Spending: Transportation in the United States",                     
               "Total Construction Spending: Transportation in the United States",                     
               "Total Construction Spending: Water Supply in the United States",                       
               "Total Construction Spending: Water Supply in the United States",                       
               "Total Construction Spending: Total Construction in the United States",                 
               "Total Construction Spending: Total Construction in the United States"   )
names(conspending_data) <-titles
rm(titles)

#consumer credit
conscredit_data <- read.csv("DATA/conscredit.csv")
rownames(conscredit_data) <- conscredit_data[,1]
conscredit_data <- conscredit_data[,-1]
names(conscredit_data) <- c("Total",
                            "Revolving",
                            "Nonrevolving"
)

#gdp index
gdpindex_data <- read.csv("DATA/gdp_index.csv")
rownames(gdpindex_data) <- gdpindex_data[,1]
gdpindex_data <- gdpindex_data[,-1]
names(gdpindex_data) <- c("Gross national product (implicit price deflator)",                                                         
 "Gross national product (chain-type price index)" ,                                                         
 "Real gross private domestic investment (chain-type quantity index)" ,                                      
 "Gross private domestic investment (implicit price deflator)",                                              
 "Real fixed investment (chain-type quantity index)",                                                        
 "Gross private domestic investment: Fixed investment (implicit price deflator)",                            
 "Real net fixed investment: Nonresidential (chain-type quantity index)" ,                                   
 "Gross private domestic investment: Fixed investment: Nonresidential (implicit price deflator)",            
 "Gross private domestic investment: Fixed investment: Nonresidential: Structures (implicit price deflator)",
 "Real net fixed investment: Residential (chain-type quantity index)" ,                                      
 "Gross private domestic investment: Fixed investment: Residential (implicit price deflator)",               
 "Exports of goods and services (implicit price deflator)" ,                                                 
 "Imports of goods and services (implicit price deflator)" ,                                                 
 "Real consumption of fixed capital: Private (chain-type quantity index)",                                   
 "Consumption of fixed capital: Private (chain-type price index)",                                           
 "Real net national product (chain-type quantity index)",                                                    
 "Net national product (chain-type price index)" ,                                                           
 "Real automobile output (chain-type quantity index)",                                                       
 "Automobile output (chain-type price index)" ,                                                              
 "Real auto output: Final sales (chain-type quantity index)",                                               
 "Automobile output: Final sales (chain-type price index)",                                                  
 "Real auto output: Personal consumption expenditures (chain-type quantity index)",                          
 "Automobile output: Personal consumption expenditures (chain-type price index)",                            
 "Real personal consumption expenditures: New motor vehicles: Autos (chain-type quantity index)",            
 "Personal consumption expenditures: New autos (chain-type price index)",                                    
 "Personal consumption expenditures: Net purchases of used autos (chain-type price index)",                  
 "Real gross domestic product: Final sales of domestic product (chain-type quantity index)",                 
 "Implicit price deflator for final sales of domestic product",                                              
 "Real gross domestic product (chain-type quantity index)",                                                  
 "Gross domestic product (implicit price deflator)",                                                         
 "Gross domestic product (chain-type price index)",                                                          
 "Real net value added: Net domestic product: General government (chain-type quantity index)",               
 "Net value added: Net domestic product: General government (chain-type price index)",                       
 "Real gross housing value added (chain-type quantity index)" ,                                              
 "Gross housing value added (chain-type price index)" ,                                                      
 "Exports of goods (implicit price deflator)"    ,                                                           
 "Imports of goods (implicit price deflator)" ,                                                              
 "Real consumption of fixed capital (chain-type quantity index)",                                            
 "Consumption of fixed capital (chain-type price index)" ,                                                   
 "Real gross domestic investment: Consumption of fixed capital (chain-type quantity index)",                 
 "Consumption of fixed capital: Government (chain-type price index)",                                        
 "Real consumption of fixed capital: General government (chain-type quantity index)",                        
 "Consumption of fixed capital: General government (chain-type price index)",                                
 "Real consumption of fixed capital: Government enterprises (chain-type quantity index)",                    
 "Consumption of fixed capital: Government enterprises (chain-type price index)" ,                           
 "Real gross domestic product: Goods: Final sales (chain-type quantity index)",                              
 "Gross domestic product: Goods: Final sales (chain-type price index)",                                      
 "Real gross domestic product: Durable goods: Final sales (chain-type quantity index)" ,                     
 "Gross domestic product: Durable goods: Final sales (chain-type price index)",                              
 "Real gross domestic product: Nondurable goods: Final sales (chain-type quantity index)" ,                  
 "Gross domestic product: Nondurable goods: Final sales (chain-type price index)",                           
 "Real gross domestic product: Services (chain-type quantity index)",                                        
 "Gross domestic product: Services (chain-type price index)" ,                                               
 "Real private fixed investment in structures (chain-type quantity index)",                                  
 "Real private fixed investment in structures (chain-type price index)",                                     
 "Real gross domestic product: Goods (chain-type quantity index)",                                           
 "Gross domestic product: Goods (chain-type price index)",                                                   
 "Real gross domestic product: Durable goods (chain-type quantity index)",                                   
 "Gross domestic product: Durable goods (chain-type price index)",                                           
 "Real gross domestic product: Nondurable goods (chain-type quantity index)",                               
 "Gross domestic product: Nondurable goods (chain-type price index)",                                        
 "Real net domestic product (chain-type quantity index)",                                                    
 "Net domestic product (chain-type price index)")             

                                                                                   
#gdp dollars seasonally adjusted annual rate
gdp_data <- read.csv("DATA/gdp_sa.csv")
rownames(gdp_data) <- gdp_data[,1]
gdp_data <- gdp_data[,-1]
names(gdp_data) <- c("Gross domestic product",
                     "Personal consumption expenditures",
                     "Goods",
                     "Durable goods",
                     "Nondurable goods",
                     "Services",
                     "Gross private domestic investment",
                     "Fixed investment",
                     "Nonresidential",
                     "Structures",
                     "Equipment",
                     "Intellectual property products",
                     "Residential",
                    " Change in private inventories",
                     "Net exports of goods and services",
                     "Exports",
                     "E. Goods",
                     "E. Services",
                     "Imports",
                     "I. Goods",
                     "I. Services",
                     "Government consumption expenditures and gross investment",
                     "Federal",
                     "National defense",
                     "Nondefense",
                     "State and local",
                     "Residual"
                    )
                     

#cpi
cpi_data <- read.csv("DATA/cpi.csv")
rownames(cpi_data) <- cpi_data[,1]
cpi_data <- cpi_data[,-1]
names(cpi_data) <- c("Consumer Price Index for All Urban Consumers: All Items in U.S. City Average",
                     "Consumer Price Index for All Urban Consumers: All Items Less Food and Energy in U.S. City Average ",
                     "Personal Consumption Expenditures: Chain-type Price Index "
                     )
#dbWriteTable(asapadb_remote, "ppi", ppi_data, row.names = TRUE, append= TRUE) 


#ppi
ppi_data <- read.csv("DATA/ppi.csv")
rownames(ppi_data) <- ppi_data[,1]
ppi_data <- ppi_data[,-1]
names(ppi_data) <-c("PPI by Commodity: Final Demand: Finished Goods",
                    "PPI by Commodity: FD: Finished Goods Less Food and Energy",
                    "PPI by Commodity: Final Demand")
#dbWriteTable(asapadb_remote, "ppi", ppi_data, row.names = TRUE, append= TRUE) 
#ppi_data <-dbReadTable(asapadb_local, "ppi")


#manufacturers orders, invs and shipments id 95
manuf_data <-read.csv("DATA/manuf.csv")
rownames(manuf_data) <-manuf_data[,1]
manuf_data <- manuf_data[,-1]
names(manuf_data) <-c("Industrial Production: Manufacturing",
"Producer Price Index by Industry: Total Manufacturing Industries ",
"New Orders Total Manufacturing",
"New Orders Exc. Transp",
"New Orders Excl. Defense")

#unemp general
unemp_data <-read.csv("DATA/unemp.csv")
rownames(unemp_data) <-unemp_data[,1]
unemp_data <- unemp_data[,-1]
names(unemp_data) <-c("Unemployment Rate",
"Unemployment Level",
"Average Weekly Hours of Production and Nonsupervisory Employees, Total Private",
"Average Hourly Earnings of Production and Nonsupervisory Employees, Total Private"
)



#jobless claims
claims_data <-read.csv("DATA/claims.csv")
rownames(claims_data) <-claims_data[,1]
claims_data <- na.omit(claims_data[,-1])
names(claims_data) <-c("Insured Unemployment Rate",
   "Initial Claims",
                      "Continued Claims (Insured Unemployment)",
                      "4-Week Moving Average of Initial Claims"
)
#"All Employees, Total Nonfarm",
#"PAYEMS"

#personal income
income_data <-read.csv("DATA/income.csv")
rownames(income_data) <-income_data[,1]
income_data <- na.omit(income_data[,-1])
names(income_data) <-c("Personal income",
                       "Compensation of employees, received",
                       "Wage and salary disbursements",
                       "Private industries",
                       "Government",
                      "Supplements to wages and salaries",
                       "Proprietors income with inventory valuation and capital consumption adjustments",
     "Farm",
     "Nonfarm",
   "Rental income of persons with capital consumption adjustment",
   "Personal income receipts on assets",
     "Personal interest income",
     "Personal dividend income",
   "Personal current transfer receipts",
     "Government social benefits to persons",
"Social security",
"Unemployment insurance",
     "Other current transfer receipts, from business (net)",
   "Less: Contributions for government social insurance",
"Less: Personal current taxes",
"Equals: Disposable personal income",
"Less: Personal outlays",
"Personal consumption expenditures",
  "Personal interest payments",
 "Personal current transfer payments",
"Equals: Personal saving",
  "Personal saving as a percentage of disposable personal income",
     " Disposable Personal Income: Per capita: Current dollars",
  "Population (midperiod, thousands)"
)

#wholesale
wholesale_data <-read.csv("DATA/wholesale.csv")
rownames(wholesale_data) <-wholesale_data[,1]
wholesale_data <- na.omit(wholesale_data[,-1])
names(wholesale_data) <-c("Total Merchant Wholesalers, Except Manufacturers Sales Branches and Offices",
"Durable Goods",
"Motor Vehicle & Motor Vehicle Parts & Supplies",
"Furniture & Home Furnishings",
"Lumber & Other Construction Materials",
"Professional & Commercial Equipment & Supplies",
"Computer & Computer Peripheral Equipment & Software",
"Metals & Minerals, Except Petroleum",
"Electrical & Electronic Goods",
"Hardware, & Plumbing, Heating Equipment, & Supplies",
"Machinery, Equipment, & Supplies",
"Miscellaneous Durable Goods",
"Paper & Paper Products",
"Drugs & Druggists Sundries",
"Apparel, Piece Goods, & Notions",
"Grocery & Related Products",
"Farm Product Raw Materials",
"Chemicals & Allied Products",
"Petroleum & Petroleum Products",
"Beer, Wine, & Distilled Alcoholic Beverages",
"Miscellaneous Nondurable Goods",
"Inventories Total Merchant Wholesalers, Except Manufacturers Sales Branches and Offices",
"Inventories Motor Vehicle & Motor Vehicle Parts & Supplies",
"Inventories Furniture & Home Furnishings",
"Inventories Lumber & Other Construction Materials",
"Inventories Professional & Commercial Equipment & Supplies",
"Inventories Computer & Computer Peripheral Equipment & Software",
"Inventories Metals & Minerals, Except Petroleum",
"Inventories Electrical & Electronic Goods",
"Inventories Hardware, & Plumbing, Heating Equipment, & Supplies",
"Inventories Machinery, Equipment, & Supplies",
"Inventories Miscellaneous Durable Goods",
"Inventories Nondurable Goods",
"Inventories Paper & Paper Products",
"Inventories Drugs & Druggists Sundries",
"Inventories Apparel, Piece Goods, & Notions",
"Inventories Grocery & Related Products",
"Inventories Farm Product Raw Materials",
"Inventories Chemicals & Allied Products",
"Inventories Petroleum & Petroleum Products",
"Inventories Beer, Wine, & Distilled Alcoholic Beverages",
"Inventories Miscellaneous Nondurable Goods",
"Inventories/Sales Ratio Total Merchant Wholesalers, Except Manufacturers Sales Branches and Offices",
"Inventories/Sales Ratio Durable Goods",
"Inventories/Sales Ratio Motor Vehicle & Motor Vehicle Parts & Supplies",
"Inventories/Sales Ratio Furniture & Home Furnishings",
"Inventories/Sales Ratio Lumber & Other Construction Materials",
"Inventories/Sales Ratio Professional & Commercial Equipment & Supplies",
"Inventories/Sales Ratio Computer & Computer Peripheral Equipment & Software",
"Inventories/Sales Ratio Metals & Minerals, Except Petroleum",
"Inventories/Sales Ratio Electrical & Electronic Goods",
"Inventories/Sales Ratio Hardware, & Plumbing, Heating Equipment, & Supplies",
"Inventories/Sales Ratio Machinery, Equipment, & Supplies",
"Inventories/Sales Ratio Miscellaneous Durable Goods",
"Inventories/Sales Ratio Nondurable Goods",
"Inventories/Sales Ratio Paper & Paper Products",
"Inventories/Sales Ratio Drugs & Druggists Sundries",
"Inventories/Sales Ratio Apparel, Piece Goods, & Notions",
"Inventories/Sales Ratio Grocery & Related Products",
"Inventories/Sales Ratio Farm Product Raw Materials",
"Inventories/Sales Ratio Chemicals & Allied Products",
"Inventories/Sales Ratio Petroleum & Petroleum Products"#,
#"Inventories/Sales Ratio Beer, Wine, & Distilled Alcoholic Beverages",
#"Inventories/Sales Ratio Miscellaneous Nondurable Goods"
)

#retail
retail_data <-read.csv("DATA/retail.csv")
rownames(retail_data) <-retail_data[,1]
retail_data <- retail_data[,-1]
names(retail_data) <-c("Retail Trade and Food Services",
                      "Retail Trade and Food Services, excluding Auto",
                      "Motor Vehicle and Parts Dealers",
                      "Auto and Other Motor Vehicles",
                      "Automotive Parts, Acc., and Tire Stores"
)

#retail
retail_data <-read.csv("DATA/retail.csv")
rownames(retail_data) <-retail_data[,1]
retail_data <- retail_data[,-1]
names(retail_data) <-c("Retail Trade and Food Services",
                       "Retail Trade and Food Services, excluding Auto",
                       "Motor Vehicle and Parts Dealers",
                       "Auto and Other Motor Vehicles",
                       "Automotive Parts, Acc., and Tire Stores"
)

#adv retail
advretail_data <-read.csv("DATA/advretail.csv")
rownames(advretail_data) <-advretail_data[,1]
advretail_data <- advretail_data[,-1]
names(advretail_data) <-c("Advance Retail Trade and Food Services",
                       "Advance Retail Trade and Food Services, excluding Auto",
                       "Advance Motor Vehicle and Parts Dealers",
                       "Advance Auto and Other Motor Vehicles"
)


#autos
autos_data <-read.csv("DATA/autos.csv")
rownames(autos_data) <-autos_data[,1]
autos_data <- autos_data[,-1]
names(autos_data) <-c("Autos  -- not seasonally adjusted (Thousands)",
                      "Light Trucks  -- not seasonally adjusted (Thousands) ",
                      "Light Total  --not seasonally adjusted (Thousands)",
                      "Total  -- not seasonally adjusted (Thousands)",
                      "Autos -- seasonally adjusted at annual rates (Millions)",
                      "Light Trucks -- seasonally adjusted at annual rates (Millions)",
                      "Light Total -- seasonally adjusted at annual rates (Millions)",
                      "Total -- seasonally adjusted at annual rates (Millions)"
)

#cpi int

cpi_int_data <-read.csv("DATA/cpi_int.csv")
rownames(cpi_int_data) <-cpi_int_data[,1]
cpi_int_data <- cpi_int_data[,-1]
names(cpi_int_data) <-c("China",
                      "USA",
                      "Japan",
                      "United Kingdom",
                      "India",
                      "Germany",
                      "Brazil",
                      "France",
                      "Mexico",
                      "Russian Federation"
)

#import export

importexport_data <- read_excel("DATA/importexport.xlsx")
importexport_data <- as.data.frame(importexport_data)
rownames(importexport_data) <- importexport_data[,1]
importexport_data <-importexport_data[,-1]
names(importexport_data) <- c("Exp - All Commodities",
                              "Exp - Agricultural",
                              "Exp - non Agricultural",
                              "Imp - All Commodities",
                              "Imp - Fuels And Lubric",
                              "Imp - All w/o Fuel")

#ism
ism_data <-read.csv("DATA/ism.csv")
rownames(ism_data) <-ism_data[,1]
ism_data <- ism_data[,-1]
names(ism_data) <-c("PMI", 
                    "New Orders", 
                    "Production",
                    "Employment",
                    "Supp. Deliveries", 
                    "Man. Inventories", 
                    "Cust. Inventories",
                    "Man.Prices", 
                    "Backlog of Ord", 
                    "New Exports", 
                    "Imports")
#ism serv
ism_s_data <-read.csv("DATA/ism_s.csv")
rownames(ism_s_data) <-ism_s_data[,1]
ism_s_data <- ism_s_data[,-1]
names(ism_s_data) <-c("NMI", 
                    "Business Activity", 
                    "New Orders",
                    "Employment",
                    "Supp. Deliveries", 
                    "Inventories", 
                    "Prices",
                    "Backlog of Ord", 
                    "New Exports", 
                    "Imports",
                    "Inv. Sentiment")



#houstarts

houst_data <- read.csv("DATA/houst.csv")
rownames(houst_data) <- houst_data[,1]
houst_data <- houst_data[,-1]
names(houst_data) <-c("Total",
                      "1 unit",
                      "5 units or more",
                      "NE Total",
                      "NE 1 unit",
                      "MW Total",
                      "MW 1 unit",
                      "South Total",
                      "South 1 unit",
                      "West Total",
                      "West 1 unit")
#building permits
permits_data <- read.csv("DATA/permits.csv")
rownames(permits_data) <- permits_data[,1]
permits_data <- permits_data[,-1]
names(permits_data) <-c("Total",
                      "1 unit",
                      "2to4 units",
                      "5 units or more",
                      "NE Total",
                      "NE 1 unit",
                      "MW Total",
                      "MW 1 unit",
                      "South Total",
                      "South 1 unit",
                      "West Total",
                      "West 1 unit")
