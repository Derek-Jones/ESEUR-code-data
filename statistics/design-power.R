#
# design-power.R,  6 Sep 18
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example

source("ESEUR_config.r")


library("diagram")

# OMA_default=c(2, 2, 1, 1)
# MAR_default=c(3, 4.2, 1, 1)+0.1
par(oma=c(1, 0.5, 1, 0.5))
par(mar=c(1, 0.5, 1, 0.5))

plot.new()

# plot_wide()

# Add some fake nodes so the inner ones are pushed in
coords=coordinates(c(1, 1, 1, 2, 1, 1, 1))

x_radius=0.25
y_radius=0.25

textellipse(coords[3, ], radx=x_radius, rady=x_radius,
		shadow.size=0.0, cex=1.2,
		box.col=rgb(0, 0, 0.9, alpha=0.15), lcol="yellow",
		lab=c("Sample Size", "N", ""))
textellipse(coords[6, ], radx=x_radius, rady=x_radius,
		shadow.size=0.0, cex=1.2,
		box.col=rgb(0, 0, 0.9, alpha=0.15), lcol="yellow",
		lab=c("", "", "Effect Size", "ES"))
textellipse(coords[4, ], radx=x_radius, rady=x_radius, cex=1.1,
		shadow.size=0.0, adj=c(0.5, 0.5),
		box.col=rgb(0, 0.9, 0, alpha=0.15), lcol="yellow",
		lab=c("", "Power", "1-P(Type II Error)", ""))
textellipse(coords[5, ], radx=x_radius, rady=x_radius, cex=1.1,
		shadow.size=0.0, adj=c(0.40, 0.40),
		box.col=rgb(0, 0.9, 0, alpha=0.15), lcol="yellow",
		lab=c("", "Significance Level", "P(Type I Error)", ""))

# grid.newpage()

