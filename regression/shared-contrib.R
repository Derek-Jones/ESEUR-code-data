#
# shared-contrib.R,  2 Aug 19
# Data from:
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG example


source("ESEUR_config.r")


library("VennDiagram")


pal_col=rainbow_hcl(3)


# This package uses the grid package for its graphics
grid.newpage()
vp=viewport(width=0.4, height=0.4)
pushViewport(vp)

venn.plot = draw.triple.venn(
		area1 = 90,
		area2 = 75,
		area3 = 100,
		n12 = 20,
		n23 = 25,
		n13 = 35,
		n123 = 15,
		label.col=c("yellow", "green", "yellow", "red", "blue", "red", "yellow"),
		category = c(expression(X[2]), expression(X[1]), "Y"),
		fill = c(pal_col[2], pal_col[3], pal_col[1]),
		lty = "blank",
#		lwd=rep(1.5, 3),
# Scaling does not have the desired effect,
# which might not be mathematically possible anyway.
#		euler.d=TRUE, scaled=TRUE, overrideTriple=TRUE,
		cex = 1.2,
		cat.cex = 1.3,
		# cat.col = c("blue", "red", "green"),
		cat.dist = c(0.02, 0.02, 0.01),
		cat.pos = c(140, 220, 0),
		rotation.degree=180
             )
grid.draw(venn.plot)
popViewport()

