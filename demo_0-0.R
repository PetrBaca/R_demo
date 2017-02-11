
# clear all
# rm(list = ls())

## =-=-=-=-=-=-=-=-=-=-= ##
## LIBRARIES
## =-=-=-=-=-=-=-=-=-=-= ##

library('xts')
library('Quandl')

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

# plot data
par(mfrow = c(2, 2),
  mar = c(5,3,3,2), oma = c(3,0,3,0),
  cex = 0.7, bty = "n",
  las = 1, adj = 0)
for (i in 1:ncol(dat)) {
  plot(dat[,i], main = nm[i], type = "n", auto.grid = F)
  lines(dat[,i], col = "#003366", lwd = 2)
  abline(h = qt[i], col = "#E8600B", lwd = 3)}

# common title & legend to be added later
# test pull and push


