#R_code_vegetation_indices.r

#pacchetti da utilizzare 
library(raster)

#andiamo nella working directory giusta
setwd("/Users/Giulia/desktop/lab")

#carichiamo i file
defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")

#facciamo il plot e abbiamo, b1=NIR,b2=red, b3=green
par(mfrow=c(2,1))
plotRGB(defor1,r=1,g=2,b=3, stretch="lin")
plotRGB(defor2,r=1,g=2,b=3, stretch="lin")
