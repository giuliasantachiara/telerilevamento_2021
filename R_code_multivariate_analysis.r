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

