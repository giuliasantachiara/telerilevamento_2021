#exam_project.r

#1. calcolo della pca
#2. faccio differenza tra le due foto per vedere quanto ghiacciao è stato perso
#calcolo della deviazionbe standard o della media per vedere dove sono i punti in cui le cose sono cambiate di più











#i pacchetti utilizzati sono:
library(raster)
library(RStoolbox)#per fare classificazione
library(raster)
library(RStoolbox)
library(ggplot2)#per fare il gg plot
library(gridExtra)#per plottare ggplots insieme
#install.packages("viridis")
library(viridis)#per colorare i ggplots


#vado sulla directory di lavoro
setwd("/Users/Giulia/desktop/progetto")
#carico le immagini su r assegnando un nome ad ognuna
fuji13<-brick("fuji_oli_2013363_lrg.jpg")
fuji20<-brick("fuji_oli_2021001_lrg.jpg")
fuji13
fuji20

#plot dell'immagine
par(mfrow=c(2,2))
plotRGB(fuji13,1,2,3,stretch="lin", names.attr=c("M. Fuji 2013))
plotRGB(fuji20,1,2,3,stretch="lin", main="M.Fuji 2020")
plot(fuji13)



#perdita di ghiacciaio calcoloata sulla prima banda
b1_13<-fuji13$fuji_oli_2013363_lrg.1
b1_20<-fuji20$fuji_oli_2021001_lrg.1
diff<-b1_13-b1_20
cl<-colorRampPalette(c("white","yellow", "red"))(200)
plot(diff, col=cl)

#provo su un'altra banda
b2_13<-fuji13$fuji_oli_2013363_lrg.2
b2_20<-fuji20$fuji_oli_2021001_lrg.2
diff2<-b2_13-b2_20
cl<-colorRampPalette(c("white","yellow", "red"))(200)
plot(diff2, col=cl)

par(mfrow=c(1,2))
plot(diff, col=cl, main="banda 1")
plot(diff2, col=cl, main="banda 2")



#calcolato dev.standard della differenza, per vedere da sono i valori che si discostano di più.
#dove c'è il verde vuol dire che le cose sono cambiate di più
dev.st13<-focal(diff,w=matrix(1/25,nrow=5,ncol=5), fun=sd)
cl1<-colorRampPalette (c('blue','green','magenta'))(100)
plot(dev.st13,col=cl1)

#provo a calcolare la media
med<-focal(diff,w=matrix(1/25,nrow=5,ncol=5), fun=mean)
cl1<-colorRampPalette (c('blue','green','magenta'))(100)
plot(med,col=cl1)

par(mfrow=c(1,2))
plot(dev.st13,col=cl1, main="dev.standard")
plot(med,col=cl1, main="media")


#facciamo classificazione per vedere quanti tipi di ambienti si riconosco in questa immagine
#faccio classificazione per tutte e due le immagini
#unsupervised classification
#classifichiamo l'immagine, in particolare creiamo un modello di classificazione
clas13<-unsuperClass(fuji13, nClasses=5)
plot(clas13$map)

clas20<-unsuperClass(fuji20, nClasses=5)
plot(clas20$map)

clas_d<-unsuperClass(diff, nClasses=5)
plot(clas_d$map)

par(mfrow=c(1,2))
plot(clas13$map, main="classificazione per 2013")
plot(clas20$map, main="classificazione per 2020")



#calcolo della pca
pca13<-rasterPCA(fuji13)
plot(pca13$map)
summary(pca13$model) 
# 98% della varianza viene spiegata dalla prima banda


#-----------------------------------------------------------------------------------


#plot con anche le coordinate, serve il pacchetto di funzioni giusto però
ggRGB(fuji13,r=1,g=2,b=3, stretch="lin")



#facciamo classificazione per vedere quanti tipi di ambienti si riconosco in questa immagine
#unsupervised classification
#classifichiamo l'immagine, in particolare creiamo un modello di classificazione
classfuji13<-unsuperClass(fuji2013, nClasses=5)
#per visualizzarlo facciamo un plot
plot(classfuji13$map)

classfuji20<-unsuperClass(fuji2020, nClasses=5)
plot(classfuji20$map)

par(mfrow=c(1,2))
plot(classfuji13$map, main="Monte fuji 2013")
plot(classfuji20$map, main="Monte fuji 2020")



pairs(fuji13)#non c'entra niente



fuji13_pca<-rasterPCA(fuji2013)


#calcoliamo di quanto si sono ridotti i ghiacci, e facciamo un calcolo tra matrici
diff<-fuji2013$ - TGm$X1979annual_melt
melt_ammount
#aggiungiamo anche una palette personalizzata
clb<-colorRampPalette(c("blue","white", "red"))(100)
plot(melt_ammount, col=clb)
#facciamo anche con il comando levelplot
levelplot(melt_ammount, col.regions=clb)







f13<-ggplot()+
#ho spiegato quale raster usare e tutta la questione di definire la geometria, le estetiche e il mapping, dove la x e la y sono le coordinate geografiche
geom_raster(pca13, mapping=aes(x=x, y=y, fill=layer))+
#aver utilizzato la deviazione standard mette in evidenza tutti i picchi della catena montuosa, mentre la macchia scura è un nuvola perchè ha dev. st. bassissima.
#metodo migliore per individuare qualsiasi tipo di discontinuità a livello geografico, naturalistico, urbano, variabilità geomorfologica e anche ecologica esempio gli ecotoni (passaggi da un ambiente all'altro)
#il prossimo comdando permette diusare un pacchetto che permette la visualizzazione dei colori, noi utilizziamo proprio una palette di colori stabilita da questo pacchetto
scale_fill_viridis(option = "viridis")  +
#con questa funzione aggiungiamo un titolo
ggtitle("BHOO")
