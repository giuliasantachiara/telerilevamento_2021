R_code_variability.r

#pacchetti da utilizzare 
library(raster)
library(RStoolbox)
library(ggplot2)#per fare il gg plot
library(gridExtra)#per plottare ggplots insieme
install.packages("viridis")
library(viridis)#per colorare i ggplots

#andiamo nella working directory giusta
setwd("/Users/Giulia/desktop/lab")
#importaimo l'immagine su cui dobbiamo lavorare, la funzione brick fa caricare le bande tutte assieme
sent<-brick("sentinel.png")
#vediamo com'è l'immagine facendo un plotRGB dove abbiamo r=1, g=2, b=3 e rispettivamente NIR 1, RED 2, GREEN 3
#non dobbiamo specificiare niente nell'inserimento delle bande perchè sono già nell'ordine giusto
plotRGB(sent, stretch="lin")

#per fare calcolo della deviazioni standard utilizziamo una sola banda, quindi dobbiamo trovare il modo di compattare tutto in una sola banda
#andiamo a trovare il nome delle bande
sent
#interessano le bande 1 nir e 2 red.
nir<-sent$sentinel.1
red<-sent$sentinel.2
#calcoliamo l'indice di vegetazione normalizzato per andare a creare lo ''strato'' sul quale andremo a lavorare
ndvi<- (nir-red)/(nir+red)
plot(ndvi)#dove c'è bianco non c'è vegetazione, nel marroncino non c'è vegetazione perchè siamo sotto a valori di 0 infatti sarà roccia, nelle parti gialle e verdi invece abbiamo le piante 
#per cambiare palette di colori dell'immagine
cl<-colorRampPalette(c('black','white','magenta','blue','green'))(100)
plot(ndvi, col=cl)

#ora che ho creato lo strato dove lavorare utilizzo la funzione focal per fare i calcoli statistici che riguardano il calcolo della deviazione standard
#oggetto, matrice di lavoro che ha 3 righe e tre colonne e fun ci dice l'operazione da svolgere
ndvisd3<-focal(ndvi,w=matrix(1/9,nrow=3,ncol=3), fun=sd)
cl1<-colorRampPalette (c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd3, col=cl1)

#calcolo media
#sempre funzione focal cambiando l'impostazione
ndvimean3<-focal(ndvi,w=matrix(1/9,nrow=3,ncol=3), fun=mean)
cl1<-colorRampPalette (c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvimean3, col=cl1)

#aumentiamo il numero di pixel per fare una prova, però il numero di pixel dipende da cosa devo studiare e l'ambiente
ndvisd11<-focal(ndvi,w=matrix(1/169,nrow=13,ncol=13), fun=sd)
cl1<-colorRampPalette (c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd13, col=cl1)

#facciamo con un numero diverso di righe e di colonne
ndvisd5<-focal(ndvi,w=matrix(1/25,nrow=5,ncol=5), fun=sd)
cl1<-colorRampPalette (c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd5, col=cl1)

#calcoliamo la PCA
sentpca<-rasterpca(sent)
#la prima pca è quella tiene il range più alto spiegato
plot(sentpca$map)

summary(sentpca$model)#la prima componente spiega 67% della variabilità, quindi è quella che da più informazioni all'interno delle immagini

#creiamo l'oggetto per la pc1
pc1<-sentpca$map$PC1
#usiamo la funzione considerando questa volta la pc1, lavoriamo su una sola banda perchè la per la deviazione standard serve solo una banda
pcsd5<-focal (pc1,w=matrix(1/9,nrow=3,ncol=3), fun=sd)
cl1<-colorRampPalette (c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(pcsd5, col=cl1)


#funzione source che va a caricare dei codici esterni scritti in precedenza
#pc1<-sentpca$map$PC1
#pcsd7<-focal (pc1,w=matrix(1/49,nrow=7,ncol=7), fun=sd)
#plot(pcsd7)
#r carica il codice senza doverlo prima personalmente analizzarlo, copiarlo e incollarlo. fa tutto in automatico e se poi si vogliono le informazioni si guardano le informazioni sul file.
source("source_test_lezione.r")
source("source_ggplot.r")

p1<-ggplot()+
#ho spiegato quale raster usare e tutta la questione di definire la geometria, le estetiche e il mapping, dove la x e la y sono le coordinate geografiche
geom_raster(pcsd5, mapping=aes(x=x, y=y, fill=layer))+
#aver utilizzato la deviazione standard mette in evidenza tutti i picchi della catena montuosa, mentre la macchia scura è un nuvola perchè ha dev. st. bassissima.
#metodo migliore per individuare qualsiasi tipo di discontinuità a livello geografico, naturalistico, urbano, variabilità geomorfologica e anche ecologica esempio gli ecotoni (passaggi da un ambiente all'altro)
#il prossimo comdando permette diusare un pacchetto che permette la visualizzazione dei colori, noi utilizziamo proprio una palette di colori stabilita da questo pacchetto
scale_fill_viridis(option = "viridis")  +
#con questa funzione aggiungiamo un titolo
ggtitle("Standard deviation of PC1 by viridis colour scale")

#una volta impostato tutto si può decidere qualche palette di colori utilizzare modificando solo il nome
p2<-ggplot()+
geom_raster(pcsd5, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis(option = "inferno")  +
ggtitle("Standard deviation of PC1 by inferno colour scale")

p3<-ggplot()+
geom_raster(pcsd5, mapping=aes(x=x, y=y, fill=layer))+
scale_fill_viridis(option = "turbo")  +
ggtitle("Standard deviation of PC1 by turbo colour scale")


#ora proviamo a mettere insieme i ggplot fatti con la funzione grid.arrange
grid.arrange(p1,p2,p3, nrow=1)





