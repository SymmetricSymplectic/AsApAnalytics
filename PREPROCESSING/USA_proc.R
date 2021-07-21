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
names(gdp_data) <- c("Private fixed investment: Residential: Structures",                                                                                                        
 "Change in private inventories: Nonfarm",                                                                                                                   
 "Gross national income",                                                                                                                                    
 "Consumption of fixed capital: Private" ,                                                                                                                   
 "Net national product",                                                                                                                                     
 "Net lending or net borrowing (-), NIPAs: Government: Statistical discrepancy",                                                                             
 "Compensation of employees: Supplements to wages and salaries",                                                                                             
 "National income: Proprietors' income with IVA: Farm" ,                                                                                                     
 "Proprietors' income with inventory valuation and capital consumption adjustments: Nonfarm",                                                                
 "Corporate profits with inventory valuation adjustment" ,                                                                                                   
 "National income: Corporate profits before tax (without IVA and CCAdj)",                                                                                    
 "Gross domestic income: Corporate profits with inventory valuation and capital consumption adjustments, domestic industries: Taxes on corporate income",    
 "Contributions for government social insurance, domestic",                                                                                                  
 "Corporate profits with inventory valuation and capital consumption adjustments: Wage accruals less disbursements (DISCONTINUED)",                          
 "Personal current transfer receipts: Government social benefits to persons",                                                                                
 "Personal income receipts on assets: Personal interest income" ,                                                                                            
 "Personal outlays"             ,                                                                                                                            
 "Federal government current tax receipts: Personal current taxes" ,                                                                                         
 "Government current transfer payments",                                                                                                                     
 "Federal government current expenditures: Interest payments",                                                                                               
 "Current receipts from the rest of the world",                                                                                                              
 "Current surplus of government enterprises" ,                                                                                                               
 "Current receipts from the rest of the world (DISCONTINUED)",                                                                                               
 "Current taxes and transfer payments to the rest of the world (net)" ,                                                                                      
 "Net private saving: Domestic business"  ,                                                                                                                  
 "Compensation of employees: Wages and salaries: Private industries",                                                                                        
 "Automobile output"           ,                                                                                                                             
 "Automobile output: Final sales" ,                                                                                                                          
 "Automobile output: Personal consumption expenditures",                                                                                                    
 "Personal consumption expenditures: New autos" ,                                                                                                            
 "Personal consumption expenditures: Net purchases of used autos",                                                                                           
 "Automobile output: Private fixed investment (DISCONTINUED)" ,                                                                                              
 "Automobile output: Net exports"   ,                                                                                                                        
 "Automobile output: Change in private inventories of new and used autos",                                                                                   
 "Change in private inventories: Nonfarm: Manufacturing",                                                                                                    
 "Change in private inventories: Nonfarm: Wholesale trade: Nondurable goods: Merchant wholesalers",                                                          
 "Change in private inventories: Nonfarm: Wholesale trade: Nondurable goods: Nonmerchant wholesalers" ,                                                      
 "Change in private inventories: Nonfarm: Retail trade",                                                                                                     
 "Change in private inventories: Nonfarm: Other durable and nondurable goods",                                                                               
 "Consumption of fixed capital: Private: Domestic: Noncorporate business: Sole proprietorships and partnerships" ,                                           
 "Consumption of fixed capital: Private: Domestic: Noncorporate business: Rental income of persons and proprietors' income",                                 
 "Government current expenditures: Interest payments" ,                                                                                                      
 "Exports of nonagricultural goods" ,                                                                                                                        
 "Government current expenditures: Wage accruals less disbursements (DISCONTINUED)",                                                                         
 "Imports of nonpetroleum goods" ,                                                                                                                           
 "National income without capital consumption adjustment: Rest of the world",                                                                                
 "Gross value added: GDP: Households and institutions"  ,                                                                                                    
 "Government consumption expenditures: Gross output of general government: Value added: Compensation of general government employees",                       
 "Gross value added: GDP: Business" ,                                                                                                                        
 "Gross housing value added"    ,                                                                                                                            
 "Government current expenditures: Interest payments: to persons and business",                                                                             
 "Current receipts from the rest of the world: Income receipts on assets: Interest" ,                                                                        
 "Wage and salary disbursements: Private industries: Goods-producing industries" ,                                                                           
 "Wage and salary disbursements: Private industries: Distributive industries"  ,                                                                             
 "Wage and salary disbursements: Private industries: Service industries" ,                                                                                   
 "Government saving: Social insurance funds",                                                                                                                
 "Current receipts from the rest of the world: Exports of goods" ,                                                                                           
 "Current payments to the rest of the world: Imports of goods",                                                                                              
 "Consumption of fixed capital: Government" ,                                                                                                                
 "Consumption of fixed capital: General government" ,                                                                                                        
 "Consumption of fixed capital: Government enterprises",                                                                                                     
 "Gross domestic product: Goods: Final sales",                                                                                                               
 "Gross domestic product: Durable goods: Final sales",                                                                                                       
 "Private fixed investment in equipment and software (DISCONTINUED)",                                                                                        
 "Current receipts from the rest of the world: Exports of durable goods",                                                                                    
 "Current payments to the rest of the world: Imports of durable goods",                                                                                      
 "Gross domestic product: Nondurable goods: Final sales",                                                                                                    
 "Current receipts from the rest of the world: Exports of nondurable goods",                                                                                 
 "Current payments to the rest of the world: Imports of nondurable goods",                                                                                   
 "Gross domestic product: Services" ,                                                                                                                        
 "Private fixed investment in structures" ,                                                                                                                  
 "Gross domestic product: Goods" ,                                                                                                                           
 "Gross domestic product: Durable goods"  ,                                                                                                                  
 "Gross domestic product: Durable goods: Change in private inventories",                                                                                     
 "Gross domestic product: Nondurable goods",                                                                                                                 
 "Gross domestic product: Nondurable goods: Change in private inventories",                                                                                  
 "Gross value added: GDP: Business: Nonfarm",                                                                                                                
 "Net domestic product" ,                                                                                                                                    
 "Corporate profits with inventory valuation adjustments: Domestic industries" ,                                                                             
 "Government saving: Other (excluding social insurance funds)",                                                                                              
 "Corporate profits with inventory valuation adjustments: Domestic industries: Financial",                                                                   
 "Corporate profits with inventory valuation adjustments: Domestic industries: Nonfinancial" ,                                                               
 "Corporate profits with inventory valuation adjustments: Domestic industries: Nonfinancial: Manufacturing (DISCONTINUED)",                                  
 "Corporate profits with inventory valuation adjustments: Domestic industries: Nonfinancial: Manufacturing: Nondurable goods (DISCONTINUED)",                
 "Corporate profits with inventory valuation adjustments: Domestic industries: Nonfinancial: Manufacturing: Nondurable goods: Food and kindred products"  ,  
 "Corporate profits with inventory valuation adjustments: Domestic industries: Nonfinancial: Manufacturing: Nondurable goods: Chemicals and allied products",
 "Corporate profits with inventory valuation adjustments: Domestic industries: Nonfinancial: Manufacturing: Nondurable goods: Petroleum and coal products",  
 "Corporate profits with inventory valuation adjustments: Domestic industries: Nonfinancial: Manufacturing: Nondurable goods: Other")


#cpi
cpi_data <- read.csv("DATA/cpi.csv")
rownames(cpi_data) <- cpi_data[,1]
cpi_data <- cpi_data[,-1]
names(cpi_data) <- c("Consumer Price Index for All Urban Consumers: All Items in U.S. City Average",
                     "Personal Consumption Expenditures Excluding Food and Energy (Chain-Type Price Index) ",
                     "Personal Consumption Expenditures: Chain-type Price Index "
                     )                

#ppi
ppi_data <- read.csv("DATA/ppi.csv")
rownames(ppi_data) <- ppi_data[,1]
ppi_data <- ppi_data[,-1]
names(ppi_data) <-c("Producer Price Index by Commodity: All Commodities",
                    "Producer Price Index by Industry: Total Manufacturing Industries",
                    "Producer Price Index by Industry: Transportation and Warehousing Industries ",
                    "Producer Price Index by Industry: Delivery and Warehouse Industries",
                    "Producer Price Index by Industry: Total Mining Industries",
                    "Producer Price Index by Industry: Total Wholesale Trade Industries",
                    "Producer Price Index by Industry: Transportation Industries",
                    "Producer Price Index by Industry: Selected Health Care Industries")   

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
unemp_data <- manuf_data[,-1]
names(unemp_data) <-c("Unemployment Rate",
"Unemployment Level",
"Average Weekly Hours of Production and Nonsupervisory Employees, Total Private",
"Average Hourly Earnings of Production and Nonsupervisory Employees, Total Private"
)

#jobless claims
#"All Employees, Total Nonfarm",
#"Initial Claims",
#"Continued Claims (Insured Unemployment)",
#"4-Week Moving Average of Initial Claims"

#"PAYEMS",

#"ICSA",
#"CCSA",
#"IC4WSA"




