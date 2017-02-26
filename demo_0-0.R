
# clear all
# rm(list = ls())

## @knitr intro

## =-=-=-=-=-=-=-=-=-=-= ##
## LIBRARIES
## =-=-=-=-=-=-=-=-=-=-= ##

# if not installed then install...
if(!require('xts')) {install.packages('xts'); library('xts')}
if(!require('Quandl')) {install.packages('Quandl'); library('Quandl')}

## =-=-=-=-=-=-=-=-=-=-= ##
## ANALYSIS
## =-=-=-=-=-=-=-=-=-=-= ##

# data info
map <- list(
  IR = list(nm = "Iran", tic = "EIA/STEO_COPR_IR_M", q = 3.80),
  IZ = list(nm = "Iraq", tic = "EIA/STEO_COPR_IZ_M", q = 4.36),
  SA = list(nm = "Saudi Arabia", tic = "EIA/STEO_COPR_SA_M", q = 10.07),
  RU = list(nm = "Russia", tic = "EIA/STEO_PAPR_RS_M", q = 10.93))

# extract information from data info
tic <- sapply(map, "[[", "tic") # Quandl codes
nm  <- sapply(map, "[[", "nm") # country names
qt  <- sapply(map, "[[", "q") # production quota

# get data from quandl
dat_raw <- Quandl(tic, type = "xts")

# remove NA's and rename columns
dat <- na.contiguous(dat_raw)
colnames(dat) <- nm

## @knitr oil_prod_plot
# plot data
par(mfrow = c(2, 2),
  mar = c(4,3,2,2), oma = c(1,0,2,0),
  cex = 0.7, bty = "n",
  las = 1, adj = 0)
for (i in 1:ncol(dat)) {
  plot(dat[,i], main = nm[i], type = "n", auto.grid = F)
  lines(dat[,i], col = "#003366", lwd = 2)
  abline(h = qt[i], col = "#E8600B", lwd = 1, lty = 3)}
title(main = "Oil production (mbpd)", outer = TRUE, adj = 0.01, cex.main = 1.6)
title(sub = "Source: EIA (via Quandl)", outer = TRUE, line = 0, adj = 1)

## end
## to be continued..
