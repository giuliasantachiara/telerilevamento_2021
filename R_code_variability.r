R_code_variability.r

#pacchetti da utilizzare 
library(raster)
library(RStoolbox)

#andiamo nella working directory giusta
setwd("/Users/Giulia/desktop/lab")
#importaimo l'immagine su cui dobbiamo lavorare
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

#facciamo 
ndvisd5<-focal(ndvi,w=matrix(1/25,nrow=5,ncol=5), fun=sd)
cl1<-colorRampPalette (c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(ndvisd5, col=cl1)

#calcoliamo la PCA
sentpca<-rasterpca(sent)
#la prima pca è quella tiene il range più alto spiegato
plot(sentpca$map)

summary(sentpca$model)#la prima componente spiega 67% della variabilità



