#
# Net-Open_BSD.R,  8 Jan 16
#
# Data from:
#
# Baishakhi Ray
# Analysis of Cross-System Porting and Porting Errors in Software Projects
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


#BSD=read.csv(paste0(ESEUR_dir, "ecosystem/Net-Open_BSD.csv.xz"), as.is=TRUE)
BSD=read.csv(paste0(ESEUR_dir, "ecosystem/Open-Net_BSD.csv.xz"), as.is=TRUE)

# BSD$NetBSD.current=NULL

pal_col=rainbow_hcl(1+nrow(BSD))


BSD_perc=aaply(as.matrix(BSD), 2, function(vec) 100*vec/vec[length(vec)])
# Transpose back to original row/column
BSD_perc=t(BSD_perc)
# Remove the Total change row
BSD_perc=BSD_perc[-nrow(BSD_perc), ]

# Strip OpenBSD_
t=substring(colnames(BSD_perc), 9)
colnames(BSD_perc)=t

#pdf(file="Net-Open_BSD.pdf")

#t=barplot(BSD_perc, col=pal_col, border=FALSE,
barplot(BSD_perc, col=pal_col, border=FALSE,
	xlab="OpenBSD releases", ylab="Percentage of changes ported from NetBSD\n")
#plot(t)


