#
# feldman_cases76.R,  1 Dec 16
# Data from:
# Minimization of Boolean complexity in human concept learning
# Jacob Feldman
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

feld=read.csv(paste0(ESEUR_dir, "developers/feldman_cases76.csv.xz"), as.is=TRUE)
feld$col=pal_col[feld$P-1]
up=subset(feld, Parity == "up")
down=subset(feld, Parity == "down")

# plot(up$BC, up$PropCorr*100, col=up$col, pch=2,
plot(feld$BC, feld$PropCorr*100, col=feld$col,
	xlab="Boolean complexity", ylab="Percent correct\n")

# points(down$BC, down$PropCorr*100, col=up$col, pch=6)

legend(x="bottomleft", legend=c("P = 2", "P = 3", "P = 4"), bty="n", fill=pal_col, cex=1.2)

# library("betareg")
# 
# f_mod=betareg(PropCorr ~ Parity+BC+Parity:P, data=feld)
# summary(f_mod)

