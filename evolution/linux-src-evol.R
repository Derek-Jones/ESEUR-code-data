#
# linux-src-evol.R, 26 Mar 16
#
# Data from:
# Simone Livieri and Yoshiki Higo and Makoto Matsushita and Katsuro Inoue
# Analysis of the {Linux} Kernel Evolution Using Code Clone Coverage
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("lattice")


evol=read.csv(paste0(ESEUR_dir, "evolution/linux-src-evol.csv.xz"), as.is=TRUE, header=FALSE)

evol=as.matrix(evol)

#pal_col=heat.colors(30)
# Add white for the lowest value
pal_col=c("#FFFFFFFF", pal_col)

t=levelplot(evol, col.regions=pal_col,
	scales=list(x=list(at=c(1, 130-60, 130),
			   label=c("1.2.0", "2.2.20", "2.6.18.3")),
		    y=list(at=c(130, 60, 1),
				 label=c("1.2.0", "2.2.20", "2.6.18.3"))),
	xlab="", ylab="")

plot(t, panel.height=list(3.8, "cm"), panel.width=list(5.2, "cm"))

# The base library approach (with no legend)
# image(evol, col=pal_col, axes=FALSE)
# axis(1, at=c(0, 1-60/130, 1), label=c("1.2.0", "2.2.20", "2.6.18.3"))
# axis(2, at=c(1, 60/130, 0), label=c("1.2.0", "2.2.20", "2.6.18.3"))

