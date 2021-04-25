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


