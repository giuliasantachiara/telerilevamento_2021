#R_code_no2.r

#i pacchetti che ci servono:
library(raster)
library(RStoolbox)#per l'analisi multivariata

#1. set della working directory

setwd("/Users/Giulia/desktop/lab/EN")

#2. carichiamo su R l'immagine su cui dobbiamo lavorare, solamente una banda

#utilizzo la funzione raster
en1<-raster ("EN_0001.png")

#3. plottiamo l'immagine scegliendo una palette di colori
#creo prima una palette di colori
cl<-colorRampPalette(c("blue","light blue", "white"))(100)
#poi plotto l'immagine
plot(en1, col=cl)

#4. importiamo la 13 esima immagine e la plottiamo con la palette che abbiamo creato
en13<-raster ("EN_0013.png")
cl<-colorRampPalette(c("blue","light blue", "white"))(100)
plot(en13, col=cl)

#5. andiamo a vedere la differenza tra le due immagini e poi plottiamo
diff<-en13-en1
plot(diff,col=cl)

#6. plottiamo tutte le immagini insime
par(mfrow=c(3,1))
plot(en1, col=cl, main="N02 a gennaio")
plot(en13, col=cl, main="NO2 a marzo")
plot(diff,col=cl, main="differenza tra gennaio e marzo")

#7. plottiamo tutte le immagini del set insieme
#facciamo una lista del files
enlist<-list.files(pattern="EN")
import<-lapply(enlist,raster)
EN<-stack(import)
plot(EN,col=cl)

#8. plot dell'immagine 1 e 13 tirate fuori dallo stack
par(mfrow=c(2,1))
plot(EN$EN_0001,col=cl)
plot(EN$EN_0013,col=cl)

#9. fare la PCA delle 13 immagini
#facciamo la rasterPCA, quindi inseriamo il pacchetto all'inizio
en_pca<-rasterPCA(EN)
summary(en_pca$model)
plotRGB(en_pca$map,r=1, g=2, b=3,stretch="lin")

#10. calcolare la variabilità sulla prima componente
#faccio calcolo della standard deviation
pc1sd<-focal(en_pca$PC, w=matrix(1/9, nrow=3,ncol=3), fun=sd)








