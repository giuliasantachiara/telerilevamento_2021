#R_code_knitr.r



#indirizziamo nella giusta working directory
setwd("/Users/Giulia/desktop/lab/greenland/")

library(knitr)

#andiamo a trovare il nostro codice che abbiamo creato in precedenza
stitch("R_code_greenland.r", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
