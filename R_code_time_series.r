#time series analysis
#greenland increase of temperature
#data and code from Emanuela Costa

#carichiamo il pacchetto raster
library(raster)
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

#lapply funzione che mi permette di applicare la funzione raster a una lista di file. con un solo comando carico tante informazionià
#prima quindi facciamo la lista dei file che voglio caricare su R, nel pattern mettiamo il nume che tutti i file hanno in comune
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
