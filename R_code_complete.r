#R code complete - Telerilevamento Geo-Ecologico

#------------------------------------------------

#summary:

#1. Remote sensing - first code
#2. R code time series
#3. R code copernicus data
#4. R code knitr
#5. R code multivariate analysis
#6. R code classification
#7. R code ggplot2
#8. R code vegetation indices
#9. R code land cover
#10. R code variability
#11. R code spectral signatures
#--------------------------------------------------
# Il mio primo codice in R!

# comando che mi serve per selezionare la cartella di lavoro
setwd("/Users/Giulia/desktop/lab/")

#install.packages("raster")
library(raster)

#il comando brick mi serve per importare dentro ad R, brick vuol dire che importiamo l'intero set di bande
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

#multitemporal set
p224r63_1988<-brick("p224r63_1988_masked.grd")
p224r63_1988

#vediamo immagine delle bande, le bande sono le stesse dell'immagine del 2011
plot(p224r63_1988)
#plot con la classificazione rgb abbiamo r=3, g=2, b=1 e strech per stirare i nostri valori
plotRGB(p224r63_1988,r=3,g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988,r=4,g=3, b=2, stretch="Lin")


#mettiamo insieme le due immagini 
par(mfrow=c(2,1))
plotRGB(p224r63_1988,r=3,g=2, b=1, stretch="Lin")
plotRGB(p224r63_1988,r=4,g=3, b=2, stretch="Lin")

#mettiamo insieme immagini--> nella prima riga mettiamo quelle lineari, mentre nella seconda riga istogram strech
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988,r=4,g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011,r=4,g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988,r=4,g=3, b=2, stretch="hist")
plotRGB(p224r63_2011,r=4,g=3, b=2, stretch="hist")
dev.off()

#----------------------------------------------------------------

# 2. R code time series

#time series analysis
#greenland increase of temperature
#data and code from Emanuela Costa

#carichiamo i pacchetti che dobbiamo utilizzare
#install.packages("raster")
#install.packages("rasterVis")
library(raster)
library(rasterVis)
#indirizziamo nella giusta working directory
setwd("/Users/Giulia/desktop/lab/greenland")
#dati che analizziamo sono presi da copernicus e sono delle temperature

#carichiamo i singoli dati
lst_2000<-raster("lst_2000.tif")
#e carichiamo l'immagine
plot(lst_2000)
lst_2005<-raster("lst_2005.tif")
plot(lst_2005)
lst_2010<-raster("lst_2010.tif")
plot(lst_2010)
lst_2015<-raster("lst_2015.tif")
plot(lst_2015)
#mettiamo nella stessa schermata tutte le immagini per avere visione generale
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)
dev.off()

#lapply funzione che mi permette di applicare la funzione raster a una lista di file. con un solo comando carico tante informazioni
#prima quindi facciamo la lista dei file che voglio caricare su R, nel pattern mettiamo il nome che tutti i file hanno in comune
rlist<-list.files(pattern="tif")
rlist
#una volta fatta la lista faccio il comando che applica a tutti la stessa funzione
import<-lapply(rlist, raster)
import
#impacchettiamo tutti i file insieme con la funzione stack e li plottiamo, quindi con una funzione facciamo quello che facevano con tanti comandi
TGr<-(stack(import))
plot(TGr)
#proviamo a plottare immagine con classificazione RGB
plotRGB(TGr,1,2,3,stretch="Lin")
#se abbiamo più colori scuri allora vuol dire che impatta di più l'immagine che si trova nella banda blu
#proviamo a invertire le immagini
plotRGB(TGr,2,3,4,stretch="Lin")

#è questo compando è simile al comando plot ma è molto più potente e da una visualizzazione migliore
levelplot(TGr)
levelplot(TGr$lst_2000)
#assegnamo un nuova palette di colori
cl<-colorRampPalette(c("blue","light blue","pink", "red"))(100)
levelplot(TGr, col.regions=cl)
# se vogliamo cambiare palette e titolo
levelplot(TGr, col.regions=cl, names.attr=c("July 2000", "July 2005", "July 2010", "July 2015"))

#guardiamo nuvo set di dati di melt Geenland
m_list<-list.files(pattern="melt")
m_list
#una volta fatta la lista faccio il comando che applica a tutti la stessa funzione--> lapply
m_import<-lapply(mlist, raster)
m_import
#impacchettiamo tutti i file insieme con la funzione stack e li plottiamo, quindi con una funzione facciamo quello che facevano con tanti comandi
TGm<-(stack(m_import))
TGm<-(stack(m_import))
#facciamo un level plot dei dati
levelplot(TGm)
#calcoliamo di quanto si sono ridotti i ghiacci, e facciamo un calcolo tra matrici
melt_ammount<-TGm$X2007annual_melt - TGm$X1979annual_melt
melt_ammount
#aggiungiamo anche una palette personalizzata
clb<-colorRampPalette(c("blue","white", "red"))(100)
plot(melt_ammount, col=clb)
#facciamo anche con il comando levelplot
levelplot(melt_ammount, col.regions=clb)

#-------------------------------------------------
3. R code copernicus

#R_code_copernicus.r
#visualizzazione Copernicus

#per leggere i dati abbiamo bisogno di questi pacchetti
library(raster)
#install.packages("ncdf4")
library(ncdf4)

#andiamo nella working directory giusta
setwd("/Users/Giulia/desktop/lab")

#diamo un nome al nostro set di dati e lo carichiamo
fuochi<-raster("c_gls_BA300_202104200000_GLOBE_PROBAV_V1.1.1.nc")

#dato che abbiamo un singolo strato stabiliamo una palette di colori
cl<-colorRampPalette(c("red","orange", "yellow"))(100)
plot(fuochi, col=cl)

#visto che la variabile è molto pesante facciamo questa funzione per semplificarla
fuochi_res<-aggregate(fuochi,fact=100)
plot(fuochi_res, col=cl)
#------------------------------------------------------------

4. R code knitr

#R_code_knitr.r



#indirizziamo nella giusta working directory
setwd("/Users/Giulia/desktop/")

library(knitr)

#andiamo a trovare il nostro codice che abbiamo creato in precedenza
stitch("R_code_greenland.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
#con questo creiamo un file .tex, da cui andiamo a generare un pdf su un altro sito
#-----------------------------------------------------------------------------------------------------

#5. R code multivariate analysis

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
#-------------------------------------------------------------------------------------------

#6. R code classification
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
#------------------------------------------------------------------------------------------------------

#7. R code ggplot2
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("~/lab/")
p224r63 <- brick("p224r63_2011_masked.grd")
ggRGB(p224r63,3,2,1, stretch="lin")
ggRGB(p224r63,4,3,2, stretch="lin")
p1 <- ggRGB(p224r63,3,2,1, stretch="lin")
p2 <- ggRGB(p224r63,4,3,2, stretch="lin")
grid.arrange(p1, p2, nrow = 2) # this needs gridExtra
#------------------------------------------------------------------------------------------------------

#8. R code vegetation indices

#R_code_vegetation_indices.r

#pacchetti da utilizzare 
library(raster)
library(RStoolbox) # for vegetation indices calculation
#install.packages("rasterdiv")
library(rasterdiv)#for the worldwide NDVI
#install.packages(rasterVis)
library(rasterVis)

#andiamo nella working directory giusta
setwd("/Users/Giulia/desktop/lab")

#carichiamo i file
defor1<-brick("defor1.jpg")
defor2<-brick("defor2.jpg")

#facciamo il plot e abbiamo, b1=NIR,b2=red, b3=green
par(mfrow=c(2,1))
plotRGB(defor1,r=1,g=2,b=3, stretch="lin")
plotRGB(defor2,r=1,g=2,b=3, stretch="lin")

#creiamo il primo indice di vegetazione e lo facciamo facendo le differenze tra le bande NIR
dvi1<-defor1$defor1.1-defor1$defor1.2
dvi1
plot(div1)
#dev.off()

#facciamo lo stesso plot ma con una color palette diversa
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi1,col=cl)

#calcoliamo il secondo indice
dvi2<-defor2$defor2.1-defor2$defor2.2
dvi2
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl)
#devo.off()
#mettiamo tutto insieme per vedere bene le differenze
par(mfrow=c(2,1))
plot(dvi1,col=cl,main="DVI at time1")
plot(dvi2,ol=cl,main="DVI at time2")

#calcoliamo differenza degli indici di vegetazione
difdvi1<-dvi1-dvi2
#plottiamo con una buova palette, dove la differenza è alta abbiamo colori rossi, mentre dove è più bassa abbiamo colore azzurrino
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi1,col=cld)

#inidice di vegetazione normalizzato
#si calcola facendo (NIR-RED)/(NIR+RED)
ndvi1<-(defor1$defor1.1-defor1$defor1.2)/(defor1$defor1.1+defor1$defor1.2)
#plottiamo
plot(ndvi1,col=cl)

#RStoolbox::spectralIndices
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi, col=cl)

vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

#worldwide NDVI
plot(copNDVI)

#Pixels with walues 253,254 and 255 (water) will be set as NA's
copNDVI<-raster::reclassify(copNDVI,cbind(252,255,NA), right=TRUE)
plot(copNDVI)

#rasterVis package needed:
levelplot(copNDVI)
#immagine di come respira la terra e abbiamo i valori media di biomassa vegetale dal 1997(circa) ad oggi

#------------------------------------------------------------------------------------------------------

#9. R code land cover

#R_code_land_cover.r

#pacchetti da utilizzare 
library(raster)
library(RStoolbox) # for vegetation indices calculation
#install.packages("ggplot2")
library(ggplot2)
#install.packages("gridExtra")
library(gridExtra)

#andiamo nella working directory giusta
setwd("/Users/Giulia/desktop/lab")

#carichiamo il dataset ed essendo tante bande usiamo il comando brick
#NIR 1 , RED 2 ,GREEN 3

defor1<-brick("defor1.jpg")
#plottiamo il dataset
plotRGB(defor1,r=1,g=2,b=3, stretch="lin")

#viene plottata l'immagine con anche le coordinate
ggRGB(defor1,r=1,g=2,b=3, stretch="lin")

#carichiamo seconda immagine
defor2<-brick("defor2.jpg")
#plottiamo il dataset
plotRGB(defor2,r=1,g=2,b=3, stretch="lin")

#viene plottata l'immagine con anche le coordinate
ggRGB(defor2,r=1,g=2,b=3, stretch="lin")

par(mfrow=c(2,1))
ggRGB(defor2,r=1,g=2,b=3, stretch="lin")
ggRGB(defor1,r=1,g=2,b=3, stretch="lin")

#multiframe with ggplot2 and gridExtra
#con questo comando che unisce i plot
p1<-ggRGB(defor1,r=1,g=2,b=3, stretch="lin")
p2<-ggRGB(defor1,r=1,g=2,b=3, stretch="lin")
grid.arrange(p1,p2,nrow=2)

#creiamo una classificiazione -> unsupervied classification perchè la classificazione viene fatta autonomamente dal programma e noi non supervisioniamo niente
#noi stabiliamo solamente il numero di classi che vogliamo creare
d1c<-unsuperClass(defor1,nClasses=2)
d1c
plot(d1c$map)#la classe numero 1 è la foresta tropicale, classe 2 è la parte agricola
#set.seed()would allow you to attain the same results
d2c<-unsuperClass(defor2,nClasses=2)
d2c
plot(d2c$map)

#proviamo classificazione 3 classi
d2c3<-unsuperClass(defor2,nClasses=3)
plot(d2c3$map)
#giallo classe della foresta amazzonica residua
#2 classi per le aree agricole che sono state divise in due tipologie
#calcoliamo quanta foresta è stata persa e lo facciamo basandoci sulla frequenza
#innanzitutto calcoliamo la frequenza di foresta
f1<-freq(d1c$map)
#i pixel che troviamo sono:
#value  count
#[1,]     1 305774
#[2,]     2  35518
#poi per arrivare al risultato dobbiamo fare una proporzione
s1<-305774+35518
prop1<-freq(d1c$map)/s1
#prop forest:0.8959308
#prop agriculture:0.1040692
#facciamo gli stessi procedimenti per la seconda immagine
s2<-341292
prop2<-freq(d2c$map)/s2
#prop agricolture: 0.4834570
#prop forest: 0.5207447

#creiamo un dataframe
#nella prima colonna mettiamo i fattori--> che sono variabili categoriche. nel nostro caso foresta e agricoltura
#nella colonna dei fattori mettiamo foresa e agricoltura
#nella seconda colonna mettiamo la percentuale 1992
#terza colonna percentuale 2006
fattori<-c("Forest","Agriculture")
percent_1992<-c(89.59, 10.41)
percent_2006<-c(52.07,48.35)

percentages<-data.frame(fattori,percent_1992, percent_2006)
percentages

#creiamo un plot con un'istogramma con i valori che abbiamo
g1<-ggplot(percentages,aes(x=fattori,y=percent_1992, color=fattori))+ geom_bar(stat="identity", fill="white")
g2<-ggplot(percentages,aes(x=fattori,y=percent_2006, color=fattori))+ geom_bar(stat="identity", fill="white")
#mettiamo i due grafici indieme usiamo funzione grid.arrange
grid.arrange(g1,g2,nrow=1)
#------------------------------------------------------------------------------------------------------

#10. R code variability

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

#------------------------------------------------------------------------------------------------------

#11. R_code_spectral_signatures.r

library(raster)
library(rgadl)
library(ggplot2)

setwd("/Users/Giulia/desktop/lab/")

defor2<-brick("defor2.jpg")

# defor2.1, defor2.2, defor2.3
#NIR, red, green

plotRGB(defor2, r=1, g=2, b=3,stretch="lin")
#sulla mappa clicco i punti e questo funzioni mi da le info su questi punti nello specifico
click(defor2, id=T, xy=T,cell=T, type="p", pch=16, cex=4, col="yellow")
#risultati-->  x     y   cell defor2.1 defor2.2 defor2.3
#1 258.5 206.5 194566      189      147      135
     # x     y   cell defor2.1 defor2.2 defor2.3
#1 215.5 156.5 230373      164       31       50

#definiamo le colonne del dataset:
band<-c(1,2,3)
forest<-c(206, 6, 19)
water<- c(40,99,139)
#creiamo effettivamente la tabella con la funzione data.frame
spectrals<-data.frame(band,forest,water)

#plot the spectral signatures
ggplot(spectrals, aes(x=band))+ #questa funzione apre un plot standard
geom_line(aes(y=forest), color="green")+
geom_line(aes(y=water), color="blue")+
labs(x="wavelenght", y="reflectance")#per dare nome agli assi

#multitemporal
defor1<-brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
#plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#spectral signatures defor1
click(defor1, id=T, xy=T,cell=T, type="p", pch=16, cex=4, col="yellow")
#risultati
# x     y   cell defor1.1 defor1.2 defor1.3
# 36.5 330.5 104995      215       20       36
 #    x     y   cell defor1.1 defor1.2 defor1.3
#1 22.5 326.5 107837      215       22       39
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 22.5 309.5 119975      203       12       27
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 49.5 308.5 120716      186       10       21
#     x     y   cell defor1.1 defor1.2 defor1.3
#1 53.5 323.5 110010      207       25       38



defor2<-brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
click(defor2, id=T, xy=T,cell=T, type="p", pch=16, cex=4, col="yellow")
#risultati
# x     y  cell defor2.1 defor2.2 defor2.3
#1 28.5 356.5 86786      175      181      171
#     x     y  cell defor2.1 defor2.2 defor2.3
#1 18.5 354.5 88210      178      169      164
 #    x     y  cell defor2.1 defor2.2 defor2.3
#1 11.5 338.5 99675      182      123      117
 #    x     y  cell defor2.1 defor2.2 defor2.3
#1 30.5 340.5 98260      204       83       98
 #    x     y  cell defor2.1 defor2.2 defor2.3
#1 41.5 355.5 87516      191      178      162


band<-c(1,2,3)
time1<-c(223, 11, 33)
time2<- c(197,163,151)

spectrals<-data.frame(band,time1,time2)

ggplot(spectrals, aes(x=band))+ #questa funzione apre un plot standard
geom_line(aes(y=time1), color="red")+
geom_line(aes(y=time2), color="grey")+
labs(x="wavelenght", y="reflectance")#per dare nome agli assi

#immagine da Earth Observatory
eo<-brick("iss064e044621_lrg.jpg")
plotRGB(eo,1,2,3,stretch="lin")
click(eo, id=T, xy=T,cell=T, type="p", pch=16, cex=4, col="yellow")
#risultati
# x     y     cell iss064e044621_lrg.1 iss064e044621_lrg.2 iss064e044621_lrg.3
#1 3243.5 801.5 12726173                  49                  77                  28
 #     x      y    cell iss064e044621_lrg.1 iss064e044621_lrg.2 iss064e044621_lrg.3
#1 713.5 2154.5 5943760                   1                  80                 113
 #      x      y    cell iss064e044621_lrg.1 iss064e044621_lrg.2 iss064e044621_lrg.3
#1 1562.5 1963.5 6901710                   0                  85                  94

#definisco le colonne
band<-c(1,2,3)
strato1<-c(49,77,28)
strato2<-c(1,80,113)
strato3<-c(0,85,94)

spectralsen<-data.frame(band,strato1,strato2,strato3)

ggplot(spectralsen, aes(x=band))+ #questa funzione apre un plot standard
geom_line(aes(y=strato1), color="blue")+
geom_line(aes(y=strato2), color="grey")+
geom_line(aes(y=strato3), color="green")+
labs(x="wavelenght", y="reflectance")#per dare nome agli assi
#------------------------------------------------------------------------------------------


















