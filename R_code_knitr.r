#R_code_knitr.r



#indirizziamo nella giusta working directory
setwd("/Users/Giulia/desktop/")

library(knitr)

#andiamo a trovare il nostro codice che abbiamo creato in precedenza
stitch("R_code_greenland.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))à
#con questo creiamo un file .tex, che poi andiamo a modificare e da cui andiamo a generare un pdf
