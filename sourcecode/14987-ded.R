#
# 14987-ded.R, 15 Jun 18
# Data from:
# Quantifying the closeness between program components and features
# W. Eric Wong and Swapna S. Gokhale and Joseph R. Horgan
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones
#
# TAG basic-block runtime feature source-file


source("ESEUR_config.r")


library("seriation")
library("grid") # Yes, seriation uses grid graphics


pal_col=heat_hcl(10)


#
# Component dedication to features
#
ded=read.csv(paste0(ESEUR_dir, "sourcecode/14987-ded.csv.xz"), as.is=TRUE)

rownames(ded)=ded$File

pmat=as.matrix(ded[, 2:7])

fser=seriate(pmat)

pimage(pmat, fser, col=rev(pal_col), key=FALSE, cex.lab=1.6,
        xlab="Features", ylab="Files")

#
# Feature concentration of components
#
# con=read.csv(paste0(ESEUR_dir, "sourcecode/14987-con.csv.xz"), as.is=TRUE)
# 
# rownames(con)=con$File
# 
# pmat=as.matrix(con[1:30, 2:7])
# 
# fser=seriate(pmat)
# 
# pimage(pmat, fser, col=rev(pal_col), key=FALSE, cex.lab=1.6,
#         xlab="Features", ylab="Files")
# 

