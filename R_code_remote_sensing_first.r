# Il mio primo codice in R!

# comando che mi serve per selezionare la cartella di lavoro
setwd("/Users/Giulia/desktop/lab/")

#install.packages("raster")
library("raster")

#il comando brick mi serve per importare dentro ad R
p224r63_2011<-brick("p224r63_2011_masked.grd")
# comando per avere visualizzazione dei dati
plot(p224r63_2011)
#noi in questo caso abbiamo 7 bande

#comando per cambiare colore dei plot e quindi delle bande, 
# con il primo comando creo una nuova palette di colori, mentre con il secondo comando inserico la palette

cl<-colorRampPalette(c("black","grey","light grey"))(100)
plot(p224r63_2011,col=cl)
#prova colori 
clnosens<-colorRampPalette(c("red","green","blue"))(100)
plot(p224r63_2011,col=clnosens)
