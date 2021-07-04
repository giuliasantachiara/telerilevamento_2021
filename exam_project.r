#exam_project.r

#1. calcolo della pca
#2. faccio differenza tra le due foto per vedere quanto ghiacciao è stato perso
#3. calcolo della deviazionbe standard o della media per vedere dove sono i punti in cui le cose sono cambiate di più




#i pacchetti utilizzati sono:
library(raster)
library(RStoolbox)#per calcolo della PCA
library(rasterVis)
library(ggplot2)#per fare il gg plot
library(gridExtra)#per plottare ggplots insieme
library(viridis)#per colorare i ggplots



#vado sulla directory di lavoro
setwd("/Users/Giulia/desktop/progetto")
#carico le immagini su r assegnando un nome ad ognuna
fuji13<-brick("fuji_oli_2013363_lrg.jpg")
fuji21<-brick("fuji_oli_2021001_lrg.jpg")
fuji13
fuji21

#plot delle immagini per vedere le 3 bande
plot (fuji13)
plot (fuji21)

#per vedere immagini con colori reali
#multiframe with ggplot2 and gridExtra
#con questo comando che unisce i plot
p1<-ggRGB(fuji13,r=1,g=2,b=3, stretch="lin")
p2<-ggRGB(fuji21,r=1,g=2,b=3, stretch="lin")
#con questo comando che unisce i plot
grid.arrange(p1,p2,nrow=1,ncol=2)




#1. calcolo della pca utilizzo la funzione rasterPCA del pacchetto RStoolbox

#calcolo pca per l'immagine del 2013
pca13<-rasterPCA(fuji13)
plot(pca13$map)
summary(pca13$model) 
#Importance of components:
                         #  Comp.1      Comp.2      Comp.3
#Standard deviation     106.809168 12.51496705 6.327041594
#Proportion of Variance   0.983054  0.01349646 0.003449544
#Cumulative Proportion    0.983054  0.99655046 1.000000000
# 98% della varianza viene spiegata dalla prima banda


#calcolo pca per l'immagine del 2021
pca21<-rasterPCA(fuji21)
plot(pca21$map)
summary(pca21$model) 
#Importance of components:
#                           Comp.1      Comp.2      Comp.3
#Standard deviation     78.9975387 12.72125301 7.616503808
#Proportion of Variance  0.9659712  0.02504937 0.008979422
#Cumulative Proportion   0.9659712  0.99102058 1.000000000




#2. calcolo perdita di manto nevoso sulla prima banda di ogni immagine
b1_13<-fuji13$fuji_oli_2013363_lrg.1 #assegno nome alla banda 1 dell'immagine del 2013
b1_21<-fuji21$fuji_oli_2021001_lrg.1 #assegno nome alla banda 1 dell'immagine del 2021

diff<-b1_13-b1_21
cl<-colorRampPalette(c("yellow","red",'blue'))(200)
plot(diff, col=cl, main="Perdita di manto nevoso")





#3. calcolo deviazione standard della differenza
#dove c'è il verde vuol dire che le cose sono cambiate di più
dev.st<-focal(diff,w=matrix(1/25,nrow=5,ncol=5), fun=sd) #stabilisco la grandezza della matrice, in questo caso è una mtrice con 5 colonne e 5 righe
cl<-colorRampPalette (c('blue','green','magenta','yellow'))(100)
plot(dev.st,col=cl,main="Deviazione Standard")



#-----------------------------------------------------------------------------------

