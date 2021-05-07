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
