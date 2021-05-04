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


















