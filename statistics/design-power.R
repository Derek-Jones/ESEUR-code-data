#
# design-power.R,  6 Sep 15
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


library("diagram")

plot.new()

# Add some fake nodes so the inner ones are pushed in
coords=coordinates(c(1, 1, 4, 1, 1))

textellipse(coords[2, ], radx=0.2, rady=0.2,
		shadow.size=0.0,
		box.col=rgb(0, 0.9, 0, alpha=0.15),
		lab=c("Power", "1-P(Type II Error)", ""))
textellipse(coords[4, ], radx=0.2, rady=0.2,
		shadow.size=0.0, adj=c(0.8, 0.8),
		box.col=rgb(0, 0, 0.9, alpha=0.15),
		lab=c("", "Sample Size", "n", ""))
textellipse(coords[5, ], radx=0.2, rady=0.2,
		shadow.size=0.0, adj=c(0.15, 0.15),
		box.col=rgb(0, 0, 0.9, alpha=0.15),
		lab=c("", "Effect Size", "ES", ""))
textellipse(coords[7, ], radx=0.2, rady=0.2,
		shadow.size=0.0,
		box.col=rgb(0, 0.9, 0, alpha=0.15),
		lab=c("", "Significance Level", "P(Type I Error)"))

# grid.newpage()

