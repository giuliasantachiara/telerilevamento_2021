#R_code_spectral_signatures.r

library(raster)
library(rgadl)

setwd("/Users/Giulia/desktop/lab/")

defor2<-brick("defor2.jpg")

# defor2.1, defor2.2, defor2.3
#NIR, red, green

plotRGB(defor2, r=1, g=2, b=3,stretch="lin")
