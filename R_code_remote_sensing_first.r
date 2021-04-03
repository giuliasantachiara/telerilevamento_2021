# Il mio primo codice in R!

# comando che mi serve per selezionare la cartella di lavoro
setwd("/Users/Giulia/desktop/lab/")

#install.packages("raster")
library("raster")

p224r63_2011<-brick("p224r63_2011_masked.grd")

#per avere visualizzazione dei dati
plot(p224r63_2011)
