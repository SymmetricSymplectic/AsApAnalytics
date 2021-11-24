#gissa

library(readxl)
library(openxlsx)
library(dplyr)
library(lubridate)

gissa_mxn <- read_excel("DATA/gissa.xlsx", sheet = 1, col_names = FALSE)
gissa_mxn <-transpose(gissa_mxn)
gissa_mxn <-as.data.frame(gissa_mxn)
names(gissa_mxn) <- gissa_mxn[2,]
gissa_mxn <- gissa_mxn[-1,]
gissa_mxn <- gissa_mxn[-1,]
gissa_mxn[,1] <- convertToDate(gissa_mxn[,1])
rownames(gissa_mxn) <- floor_date(gissa_mxn[,1], "month")
gissa_mxn <- gissa_mxn[,-1]
gissa_mxn <- mutate_all(gissa_mxn, function(x) as.numeric(as.character(x)))


gissa_usd <- read_excel("DATA/gissa.xlsx", sheet = 2, col_names = FALSE)
gissa_usd <-transpose(gissa_usd)
gissa_usd <-as.data.frame(gissa_usd)
names(gissa_usd) <- gissa_usd[2,]
gissa_usd <- gissa_usd[-1,]
gissa_usd <- gissa_usd[-1,]
gissa_usd[,1] <- convertToDate(gissa_usd[,1])
rownames(gissa_usd) <- floor_date(gissa_usd[,1], "month")
gissa_usd <- gissa_usd[,-1]
gissa_usd <- mutate_all(gissa_usd, function(x) as.numeric(as.character(x)))

gissa_mlt <- read_excel("DATA/gissa.xlsx", sheet = 3, col_names = FALSE)
gissa_mlt <-transpose(gissa_mlt)
gissa_mlt <-as.data.frame(gissa_mlt)
names(gissa_mlt) <- gissa_mlt[1,]
gissa_mlt <- gissa_mlt[-1,]
gissa_mlt[,1] <- convertToDate(gissa_mlt[,1])
rownames(gissa_mlt) <- floor_date(gissa_mlt[,1], "month")
gissa_mlt <- gissa_mlt[,-1]
gissa_mlt <- mutate_all(gissa_mlt, function(x) as.numeric(as.character(x)))


gissa_acum <-read_excel("DATA/gissa.xlsx", sheet = 4, col_names = FALSE)
gissa_acum <-transpose(gissa_acum)
gissa_acum <-as.data.frame(gissa_acum)
names(gissa_acum) <- gissa_acum[1,]
gissa_acum <- gissa_acum[-1,]
gissa_acum[,1] <- convertToDate(gissa_acum[,1])
rownames(gissa_acum) <- floor_date(gissa_acum[,1], "month")
gissa_acum <- gissa_acum[,-1]
gissa_acum <- mutate_all(gissa_acum, function(x) as.numeric(as.character(x)))

gissa_acum_usd <-read_excel("DATA/gissa.xlsx", sheet = 5, col_names = FALSE)
gissa_acum_usd <-transpose(gissa_acum_usd)
gissa_acum_usd <-as.data.frame(gissa_acum_usd)
names(gissa_acum_usd) <- gissa_acum_usd[1,]
gissa_acum_usd <- gissa_acum_usd[-1,]
gissa_acum_usd[,1] <- convertToDate(gissa_acum_usd[,1])
rownames(gissa_acum_usd) <- floor_date(gissa_acum_usd[,1], "month")
gissa_acum_usd <- gissa_acum_usd[,-1]
gissa_acum_usd <- mutate_all(gissa_acum_usd, function(x) as.numeric(as.character(x)))




detach("package:dplyr", unload=TRUE)

