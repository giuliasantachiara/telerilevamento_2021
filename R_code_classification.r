#R_code_classification.r

#pacchetti da utilizzare 
library(raster)
library(RStoolbox)

#andiamo nella working directory giusta
setwd("/Users/Giulia/desktop/lab")
#carichiamo l'immagine su r con la funzione brick, utilizziamo questa funzione èerchè abbiamo un pacchetto di dati e così vengono caricati tutti insieme
so<-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
so
#per visualizzare l'immagine di tutti e tre i livelli facciamo plotRGB
plotRGB(so,1,2,3,stretch="lin")

#unsupervised classification
#classifichiamo l'immagine, in particolare creiamo un modello di classificazione
soc<-unsuperClass(so, nClasses=3)
#per visualizzarlo facciamo un plot
plot(soc$map)

#unsupervised classification with 20 classes
sov<-unsuperClass(so, nClasses=20)
plot(sov$map)

#download an image from:
#https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
sun<-brick("Solar_Orbiter_snaps_Venus_Earth_and_Mars_pillars.png")

#unsupervised classification
sunc<-unsuperClass(sun, nClasses=3)
plot(sunc$map)











