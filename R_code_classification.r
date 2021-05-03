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


#analizziamo il Gran Canyon
#immagine scaricata da : https://landsat.visibleearth.nasa.gov/view.php?id=80948
#carichiamo l'immagine su r con la funzione brick
gc<-brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc
#visualizziamo l'immagine in rgb
plotRGB(gc,r=1,g=2,b=3, stretch="lin")
#proviamo a cambiare la visualizzazione
plotRGB(gc,r=1,g=2,b=3, stretch="hist")
#facciamo modello di classificazione
gcc2<-unsuperClass(gc,nClasses=2)
plot(gcc2$map)
#da questo plot, ad occhio, si vede che le parti più scure sono state assegnate ad una classe, mentre
#quelle più chiare sono state assegnate ad un'altra classe
#proviamo a fare una classificazione con 4 classi
gcc4<-unsuperClass(gc,nClasses=4)
plot(gcc4$map)







