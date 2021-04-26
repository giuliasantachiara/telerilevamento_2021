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
