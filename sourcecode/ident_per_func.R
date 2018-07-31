#
# ident_per_func.R, 13 Jul 18
# Data from:
# The New {C Standard}: {An} Economic and Cultural Commentary
# Derek M. Jones
# Figure 792.25
#
# Example from:
# Evidence-based Software Engineering using R
# Derek M. Jones
#
# TAG C identifiers functions


source("ESEUR_config.r")


pal_col=rainbow(2)


idpf=read.csv(paste0(ESEUR_dir, "sourcecode/ident_per_func.csv.xz"), as.is=TRUE)
uidpf=read.csv(paste0(ESEUR_dir, "sourcecode/uident_per_func.csv.xz"), as.is=TRUE)

plot(uidpf$identifiers, uidpf$functions, log="xy", col=pal_col[1],
	xlim=c(1, 100), ylim=c(5, 6e3),
	xlab="Identifiers", ylab="Functions\n")
points(idpf$identifiers, idpf$functions, col=pal_col[2])

legend(x="bottomleft", legend=c("Unique identifiers", "All identifiers"), bty="n", fill=pal_col, cex=1.2)

