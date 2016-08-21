#
# design-power.R, 15 Aug 16
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("diagram")

plot.new()

# plot_wide()

# Add some fake nodes so the inner ones are pushed in
coords=coordinates(c(1, 1, 1, 2, 1, 1, 1))

textellipse(coords[4, ], radx=0.2, rady=0.2, cex=1.1,
		shadow.size=0.0, adj=c(0.7, 0.7),
		box.col=rgb(0, 0.9, 0, alpha=0.15),
		lab=c("", "Power", "1-P(Type II Error)", ""))
textellipse(coords[3, ], radx=0.2, rady=0.2,
		shadow.size=0.0, cex=1.2,
		box.col=rgb(0, 0, 0.9, alpha=0.15),
		lab=c("Sample Size", "n", ""))
textellipse(coords[6, ], radx=0.2, rady=0.2,
		shadow.size=0.0, cex=1.2,
		box.col=rgb(0, 0, 0.9, alpha=0.15),
		lab=c("", "Effect Size", "ES"))
textellipse(coords[5, ], radx=0.2, rady=0.2, cex=1.1,
		shadow.size=0.0, adj=c(0.30, 0.30),
		box.col=rgb(0, 0.9, 0, alpha=0.15),
		lab=c("", "Significance Level", "P(Type I Error)", ""))

# grid.newpage()

