#R_code_multivariate_analysis.r

#i pacchetti che ci servono sono questi
library(raster)
library(RStoolbox)

#carichiamo la giusta directory
setwd("/Users/Giulia/desktop/lab")

#andiamo a trovare l'immagine giusta d caricare su r
#dato che la nostra immagine ha molte bande per caricarla usiamo la funzione brick
p224r63_2011<-brick("p224r63_2011_masked.grd")
p224r63_2011
plot(p224r63_2011)

#plottiamo solamente due bande, il comando pch mi sceglie la forma dei punti plottati
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=19,cex=2)

#questo comando mette in correlazione a due a due tutte le variabili del data set, e così guardiamo
#quali sono le variabili più correlate. se i valori sono perfettamente correlati l'indice deve
#risultare 1, mentre se il valore arriva a -1 allora le varibaili non sono correlate. inoltre R mette i valori
#molto correlati scritti in grande, mentre quelli poco correlati scritti in piccolo.
pairs(p224r63_2011)

#dato che per fare la pca richiede molto tempo, per accorciare i lavori procediamo in questo modo, tramite
#funzione aggregate che ggrega i pixel con la stessa media e abbassando la risoluzione
#prima cosa quindi aggreghiamo i pixel
p224r63_2011res<-aggregate(p224r63_2011,fact=10)
p224r63_2011res
#per visualizzare i cambiamenti metto vicine le due immagini
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4,g=3,b=2, stretch="lin")
plot(p224r63_2011res,r=4,g=3,b=2, stretch="lin")
library(raster)
library(RStoolbox)

#carichiamo la giusta directory
setwd("/Users/Giulia/desktop/lab")

#andiamo a trovare l'immagine giusta d caricare su r
#dato che la nostra immagine ha molte bande per caricarla usiamo la funzione brick
p224r63_2011<-brick("p224r63_2011_masked.grd")
p224r63_2011
plot(p224r63_2011)

#plottiamo solamente due bande, il comando pch mi sceglie la forma dei punti plottati
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=19,cex=2)

#questo comando mette in correlazione a due a due tutte le variabili del data set, e così guardiamo
#quali sono le variabili più correlate. se i valori sono perfettamente correlati l'indice deve
#risultare 1, mentre se il valore arriva a -1 allora le varibaili non sono correlate. inoltre R mette i valori
#molto correlati scritti in grande, mentre quelli poco correlati scritti in piccolo.
pairs(p224r63_2011)

#dato che per fare la pca richiede molto tempo, per accorciare i lavori procediamo in questo modo, tramite
#funzione aggregate che ggrega i pixel con la stessa media e abbassando la risoluzione
#prima cosa quindi aggreghiamo i pixel
p224r63_2011res<-aggregate(p224r63_2011,fact=10)
p224r63_2011res
#per visualizzare i cambiamenti metto vicine le due immagini
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4,g=3,b=2, stretch="lin")
plotRGB(p224r63_2011res,r=4,g=3,b=2, stretch="lin")

#facciamo la pca
p224r63_2011res_pca<-rasterPCA(p224r63_2011res)

summary(p224r63_2011res_pca$model)#con questo comando vediamo che la prima componente praticamente spiega il 99% della varianza
plot(p224r63_2011res_pca$map)

summary(p224r63_2011res_pca$model)

plotRGB(p224r63_2011res_pca$map,r=1,g=2,b=3,stretch="lin")

#proviamo a plottare le componenti
plot(p224r63_2011res_pca$map$PC1,p224r63_2011res_pca$map$PC2)
#per notizie aggiuntive:
str(p224r63_2011res_pca)
#con la pca quindi abbiamo selezionato un numero minore di bande, facilitando quindi il lavoro, ma che comunque ci descrivono bene tutta la varianza 














