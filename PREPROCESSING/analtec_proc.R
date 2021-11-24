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
rownames(gissa_acum) <- as.Date(as.yearqtr(gissa_acum[,1]),frac=0)
gissa_acum <- gissa_acum[,-1]
gissa_acum <- mutate_all(gissa_acum, function(x) as.numeric(as.character(x)))

gissa_acum_usd <-read_excel("DATA/gissa.xlsx", sheet = 5, col_names = FALSE)
gissa_acum_usd <-transpose(gissa_acum_usd)
gissa_acum_usd <-as.data.frame(gissa_acum_usd)
names(gissa_acum_usd) <- gissa_acum_usd[1,]
gissa_acum_usd <- gissa_acum_usd[-1,]
gissa_acum_usd[,1] <- convertToDate(gissa_acum_usd[,1])
rownames(gissa_acum_usd) <- as.Date(as.yearqtr(gissa_acum_usd[,1]), frac=0)
gissa_acum_usd <- gissa_acum_usd[,-1]
gissa_acum_usd <- mutate_all(gissa_acum_usd, function(x) as.numeric(as.character(x)))

gissa_trim <-read_excel("DATA/gissa.xlsx", sheet = 6, col_names = FALSE)
gissa_trim <-transpose(gissa_trim)
gissa_trim <-as.data.frame(gissa_trim)
names(gissa_trim) <- gissa_trim[1,]
gissa_trim <- gissa_trim[-1,]
gissa_trim[,1] <- convertToDate(gissa_trim[,1])
rownames(gissa_trim) <- as.Date(as.yearqtr(gissa_trim[,1]), frac = 0)
gissa_trim <- gissa_trim[,-1]
gissa_trim <- mutate_all(gissa_trim, function(x) as.numeric(as.character(x)))

gissa_trim_usd <-read_excel("DATA/gissa.xlsx", sheet = 7, col_names = FALSE)
gissa_trim_usd <-transpose(gissa_trim_usd)
gissa_trim_usd <-as.data.frame(gissa_trim_usd)
names(gissa_trim_usd) <- gissa_trim_usd[1,]
gissa_trim_usd <- gissa_trim_usd[-1,]
gissa_trim_usd[,1] <- convertToDate(gissa_trim_usd[,1])
rownames(gissa_trim_usd) <- as.Date(as.yearqtr(gissa_trim_usd[,1]), frac=0)
gissa_trim_usd <- gissa_trim_usd[,-1]
gissa_trim_usd <- mutate_all(gissa_trim_usd, function(x) as.numeric(as.character(x)))

gissa_udm<-read_excel("DATA/gissa.xlsx", sheet = 8, col_names = FALSE)
gissa_udm <-transpose(gissa_udm)
gissa_udm <-as.data.frame(gissa_udm)
names(gissa_udm) <- gissa_udm[1,]
gissa_udm <- gissa_udm[-1,]
gissa_udm[,1] <- convertToDate(gissa_udm[,1])
rownames(gissa_udm) <- as.Date(as.yearqtr(gissa_udm[,1]), frac=0)
gissa_udm <- gissa_udm[,-1]
gissa_udm <- mutate_all(gissa_udm, function(x) as.numeric(as.character(x)))

gissa_udm_usd <-read_excel("DATA/gissa.xlsx", sheet = 9, col_names = FALSE)
gissa_udm_usd <-transpose(gissa_udm_usd)
gissa_udm_usd <-as.data.frame(gissa_udm_usd)
names(gissa_udm_usd) <- gissa_udm_usd[1,]
gissa_udm_usd <- gissa_udm_usd[-1,]
gissa_udm_usd[,1] <- convertToDate(gissa_udm_usd[,1])
rownames(gissa_udm_usd) <- as.Date(as.yearqtr(gissa_udm_usd[,1]), frac=0)
gissa_udm_usd <- gissa_udm_usd[,-1]
gissa_udm_usd <- mutate_all(gissa_udm_usd, function(x) as.numeric(as.character(x)))

gissa_raz <-read_excel("DATA/gissa.xlsx", sheet = 10, col_names = FALSE)
gissa_raz <-transpose(gissa_raz)
gissa_raz <-as.data.frame(gissa_raz)
names(gissa_raz) <- gissa_raz[1,]
gissa_raz <- gissa_raz[-1,]
gissa_raz[,1] <- convertToDate(gissa_raz[,1])
rownames(gissa_raz) <- as.Date(as.yearqtr(gissa_raz[,1]), frac=0)
gissa_raz <- gissa_raz[,-1]
gissa_raz <- mutate_all(gissa_raz, function(x) as.numeric(as.character(x)))

gissa_raz_usd <-read_excel("DATA/gissa.xlsx", sheet = 11, col_names = FALSE)
gissa_raz_usd <-transpose(gissa_raz_usd)
gissa_raz_usd <-as.data.frame(gissa_raz_usd)
names(gissa_raz_usd) <- gissa_raz_usd[1,]
gissa_raz_usd <- gissa_raz_usd[-1,]
gissa_raz_usd[,1] <- convertToDate(gissa_raz_usd[,1])
rownames(gissa_raz_usd) <- as.Date(as.yearqtr(gissa_raz_usd[,1]), frac=0)
gissa_raz_usd <- gissa_raz_usd[,-1]
gissa_raz_usd <- mutate_all(gissa_raz_usd, function(x) as.numeric(as.character(x)))


detach("package:dplyr", unload=TRUE)

