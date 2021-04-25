#time series analysis
#greenland increase of temperature
#data and code from Emanuela Costa

#carichiamo i pacchetti che dobbiamo utilizzare
#install.packages("raster")
#install.packages("rasterVis")
library(raster)
library(rasterVis)
#prendiamo la cartella giusta
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
cl<-colorRampPalette(c("blue","light blue","pink", "red"))(100)
  







