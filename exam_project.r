#exam_project.r


#posso fare calcolo della deviazione standard e vedere qual è il punto più alto
#calcolo delle componenti principali
#classificazione
#perdita di ghiacciaio dal 2020 al 2013




#i pacchetti utilizzati sono:
library(raster)
library(RStoolbox)#per fare classificazione


#vado sulla directory di lavoro
setwd("/Users/Giulia/desktop/progetto")
#carico le immagini su r assegnando un nome ad ognuna
fuji2013<-brick("fuji_oli_2013363_lrg.jpg")
fuji2020<-brick("fuji_oli_2021001_lrg.jpg")
fuji2013
fuji2020

#plot dell'immagine
plotRBG(fuji2013,1,2,3,stretch="lin")
plotRGB(fuji2020,1,2,3,stretch="lin")



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
