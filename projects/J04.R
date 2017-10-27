#
# J04.R, 11 Sep 17
# Data from:
# Iterative Enhancement: {A} Practical Technique for Software Development
# Victor R. Basili and Albert J. Turner
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_layout(2, 1)

pal_col=rainbow(3)

J04=read.csv(paste0(ESEUR_dir, "projects/J04.csv.xz"), as.is=TRUE)

plot(J04$Procs_Funcs/max(J04$Procs_Funcs), col=pal_col[3],
	ylab="Fraction of maximum")
points(J04$Globals/max(J04$Globals), col=pal_col[1])
points(J04$Statements/max(J04$Statements), col=pal_col[2])
legend(x="bottomright", legend=c("Globals", "Statements", "Procs & Funcs"), bty="n", fill=pal_col, cex=1.2)

# Reworked to pass values via parameters, rather than globals
# after first release, things settle down after that.
plot(J04$Parameters/(J04$Globals+J04$Locals+J04$Parameters), col=pal_col[1],
	ylim=c(0.1, 0.65),
	xlab="Release", ylab="Percentage")
points(J04$Locals/(J04$Globals+J04$Locals+J04$Parameters), col=pal_col[2])
points(J04$Globals/(J04$Globals+J04$Locals+J04$Parameters), col=pal_col[3])

