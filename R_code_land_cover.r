#R_code_land_cover.r

#pacchetti da utilizzare 
library(raster)
library(RStoolbox) # for vegetation indices calculation
#install.packages("ggplot2")
library(ggplot2)
#install.packages("gridExtra")
library(gridExtra)

#andiamo nella working directory giusta
setwd("/Users/Giulia/desktop/lab")

#carichiamo il dataset ed essendo tante bande usiamo il comando brick
#NIR 1 , RED 2 ,GREEN 3

defor1<-brick("defor1.jpg")
#plottiamo il dataset
plotRGB(defor1,r=1,g=2,b=3, stretch="lin")

#viene plottata l'immagine con anche le coordinate
ggRGB(defor1,r=1,g=2,b=3, stretch="lin")

#carichiamo seconda immagine
defor2<-brick("defor2.jpg")
#plottiamo il dataset
plotRGB(defor2,r=1,g=2,b=3, stretch="lin")

#viene plottata l'immagine con anche le coordinate
ggRGB(defor2,r=1,g=2,b=3, stretch="lin")

par(mfrow=c(2,1))
ggRGB(defor2,r=1,g=2,b=3, stretch="lin")
ggRGB(defor1,r=1,g=2,b=3, stretch="lin")

#multiframe with ggplot2 and gridExtra
#con questo comando che unisce i plot
p1<-ggRGB(defor1,r=1,g=2,b=3, stretch="lin")
p2<-ggRGB(defor1,r=1,g=2,b=3, stretch="lin")
grid.arrange(p1,p2,nrow=2)
