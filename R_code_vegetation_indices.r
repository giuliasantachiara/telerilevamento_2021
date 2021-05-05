#R_code_vegetation_indices.r

#pacchetti da utilizzare 
library(raster)
library(RStoolbox) # for vegetation indices calculation
#install.packages("rasterdiv")
library(rasterdiv)#for the worldwide NDVI
#install.packages(rasterVis)
library(rasterVis)

#andiamo nella working directory giusta
setwd("/Users/Giulia/desktop/lab")

#carichiamo i file
defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")

#facciamo il plot e abbiamo, b1=NIR,b2=red, b3=green
par(mfrow=c(2,1))
plotRGB(defor1,r=1,g=2,b=3, stretch="lin")
plotRGB(defor2,r=1,g=2,b=3, stretch="lin")

#creiamo il primo indice di vegetazione e lo facciamo facendo le differenze tra le bande NIR
dvi1<-defor1$defor1.1-defor1$defor1.2
dvi1
plot(div1)
#dev.off()

#facciamo lo stesso plot ma con una color palette diversa
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1,col=cl)

#calcoliamo il secondo indice
dvi2<-defor2$defor2.1-defor2$defor2.2
dvi2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl)
#devo.off()
#mettiamo tutto insieme per vedere bene le differenze
par(mfrow=c(2,1))
plot(dvi1,col=cl,main="DVI at time1")
plot(dvi2,ol=cl,main="DVI at time2")

#calcoliamo differenza degli indici di vegetazione
difdvi1<-dvi1-dvi2
#plottiamo con una buova palette, dove la differenza è alta abbiamo colori rossi, mentre dove è più bassa abbiamo colore azzurrino
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi1,col=cld)

#inidice di vegetazione normalizzato
#si calcola facendo (NIR-RED)/(NIR+RED)
ndvi1<-(defor1$defor1.1-defor1$defor1.2)/(defor1$defor1.1+defor1$defor1.2)
#plottiamo
plot(ndvi1,col=cl)

#RStoolbox::spectralIndices
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

#worldwide NDVI
plot(copNDVI)

#Pixels with walues 253,254 and 255 (water) will be set as NA's
copNDVI<-raster::reclassify(copNDVI,cbind(252,255,NA), right=TRUE)
plot(copNDVI)

#rasterVis package needed:
levelplot(copNDVI)
#dall'immagine si vede che la maggior parte della biomassa vegetale si trova nell'esmistero nord e questo perchè c'è più luce in questa zona
#mentre i deserti stanno a 23 gradi nord perchè sopra queste zone abbiamo aria molto secca e quindi non c'è abbastanza ''umidità'' da permettere la crescita di vegetazione in questa zona









