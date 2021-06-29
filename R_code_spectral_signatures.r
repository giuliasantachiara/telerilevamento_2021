#R_code_spectral_signatures.r

library(raster)
library(rgadl)
library(ggplot2)

setwd("/Users/Giulia/desktop/lab/")

defor2<-brick("defor2.jpg")

# defor2.1, defor2.2, defor2.3
#NIR, red, green

plotRGB(defor2, r=1, g=2, b=3,stretch="lin")
#sulla mappa clicco i punti e questo funzioni mi da le info su questi punti nello specifico
click(defor2, id=T, xy=T,cell=T, type="p", pch=16, cex=4, col="yellow")
#risultati-->  x     y   cell defor2.1 defor2.2 defor2.3
#1 258.5 206.5 194566      189      147      135
     # x     y   cell defor2.1 defor2.2 defor2.3
#1 215.5 156.5 230373      164       31       50

#definiamo le colonne del dataset:
band<-c(1,2,3)
forest<-c(206, 6, 19)
water<- c(40,99,139)
#creiamo effettivamente la tabella con la funzione data.frame
spectrals<-data.frame(band,forest,water)

#plot the spectral signatures
ggplot(spectrals, aes(x=band))+ #questa funzione apre un plot standard
geom_line(aes(y=forest), color="green")+
geom_line(aes(y=water), color="blue")+
labs(x="wavelenght", y="reflectance")#per dare nome agli assi

#multitemporal
defor1<-brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
#plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#spectral signatures defor1
click(defor1, id=T, xy=T,cell=T, type="p", pch=16, cex=4, col="yellow")
#risultati
# x     y   cell defor1.1 defor1.2 defor1.3
# 36.5 330.5 104995      215       20       36
 #    x     y   cell defor1.1 defor1.2 defor1.3
#1 22.5 326.5 107837      215       22       39
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 22.5 309.5 119975      203       12       27
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 49.5 308.5 120716      186       10       21
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 53.5 323.5 110010      207       25       38



defor2<-brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T,cell=T, type="p", pch=16, cex=4, col="yellow")
#risultati
# x     y  cell defor2.1 defor2.2 defor2.3
#1 28.5 356.5 86786      175      181      171
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 18.5 354.5 88210      178      169      164
 #    x     y  cell defor2.1 defor2.2 defor2.3
#1 11.5 338.5 99675      182      123      117
 #    x     y  cell defor2.1 defor2.2 defor2.3
#1 30.5 340.5 98260      204       83       98
 #    x     y  cell defor2.1 defor2.2 defor2.3
#1 41.5 355.5 87516      191      178      162


band<-c(1,2,3)
time1<-c(223, 11, 33)
time2<- c(197,163,151)

spectrals<-data.frame(band,time1,time2)

ggplot(spectrals, aes(x=band))+ #questa funzione apre un plot standard
geom_line(aes(y=time1), color="red")+
geom_line(aes(y=time2), color="grey")+
labs(x="wavelenght", y="reflectance")#per dare nome agli assi

#immagine da Earth Observatory
eo<-brick("iss064e044621_lrg.jpg")
plotRGB(eo,1,2,3,stretch="lin")
click(eo, id=T, xy=T,cell=T, type="p", pch=16, cex=4, col="yellow")
#risultati
# x     y     cell iss064e044621_lrg.1 iss064e044621_lrg.2 iss064e044621_lrg.3
#1 3243.5 801.5 12726173                  49                  77                  28
 #     x      y    cell iss064e044621_lrg.1 iss064e044621_lrg.2 iss064e044621_lrg.3
#1 713.5 2154.5 5943760                   1                  80                 113
 #      x      y    cell iss064e044621_lrg.1 iss064e044621_lrg.2 iss064e044621_lrg.3
#1 1562.5 1963.5 6901710                   0                  85                  94

#definisco le colonne
band<-c(1,2,3)
strato1<-c(49,77,28)
strato2<-c(1,80,113)
strato3<-c(0,85,94)

spectralsen<-data.frame(band,strato1,strato2,strato3)

ggplot(spectralsen, aes(x=band))+ #questa funzione apre un plot standard
geom_line(aes(y=strato1), color="blue")+
geom_line(aes(y=strato2), color="grey")+
geom_line(aes(y=strato3), color="green")+
labs(x="wavelenght", y="reflectance")#per dare nome agli assi
