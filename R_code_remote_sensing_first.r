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
clnosens<-colorRampPalette(c("red","green","yellow"))(100)
plot(p224r63_2011,col=clnosens)

#queste sono le bande di Landsat
#B1: blu
#B2: verde
#B3: rosso
#B4: infrarosso vicino
#B5: infrarosso medio
#B6: infrarosso termico
#B7: infrarosso medio

#comando che serve per ripulire la finestra grafica
dev.off()
#simbolo per legare è il $
#plot della B1 con una scalata di colori che ho deciso prima.
plot(p224r63_2011$B1_sre)

#multiframe delle bande, ci serve per stabilire come vogliamo mettere le immagini
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
#plottiamo le prime 4 bande 
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

par(mfrow=c(2,2))
#plottiamo la banda del blue e associamo una plaette di colori
clb<-colorRampPalette(c("dark blue", "blue","light blue"))(100)
plot(p224r63_2011$B1_sre, col=clb)
#aggiungiamo anche la banda verde
clg<-colorRampPalette(c("dark green", "green","light green"))(100)
plot(p224r63_2011$B2_sre, col=clg)
#aggiungiamo anche la banda del rosso
clr<-colorRampPalette(c("dark red", "red","pink"))(100)
plot(p224r63_2011$B3_sre, col=clr)
#banda del vicino infrarosso
clnif<-colorRampPalette(c("red", "orange","yellow"))(100)
plot(p224r63_2011$B4_sre, col=clnif)

#per vedere le bande con i colori naturali devo montarle seguendo un ordine preciso che è rosso-verde-blu
#quindi nello specifico montiamo B3-B2-B1

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
#comando che mi serve per vedere anche la banda dell'infrarosso e che quindi mi permette di capire
#quanta vegetazione abbiamo, perchè colora la vegetazione di rosso, in questo caso specifico perchè l'ho associato al colore r
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
#qua abbiamo infrarossi montanto sul verde e quindi da questa visualizzazione possiamo capire anche altre cose
#esempio con il viola vediamo i suoli agricoli, in verde più scuro dove potrebbero esserci più corsi d'acqua, quindi indica l'umidità
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#montiamo infrarosso nel blu
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")


par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#salviamo l'immagine in pdf nella cartella lab che abbiamo creato
pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
dev.off()

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
#vediamo l'immagie cambianto lo stretch, ci permette di vedere quali sono le zone umide nella foresta e come si è mossa l'acqua. 
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#mettiamo immagine normale+immagine con infrarosso sul verde+immagine con lo stretch
#in questo modo mettiamo in evidenza anche ulteriori differenze che non si noterebbero senza lo stretch hist

par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

















