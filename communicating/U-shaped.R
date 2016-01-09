#
# U-shaped.R,  2 Dec 15
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


x=1:100
inv.x=1/x

y_bounds=c(0, 3.0)

pal_col=rainbow(2)

plot(x, 3*inv.x, type="l", col=pal_col[1],
	ylim=y_bounds,
	xlab="LOC", ylab="Faults/LOC\n")

lines(x, ((x+50)^3/500)*0.01*inv.x, col=pal_col[2])


