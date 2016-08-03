#
# shared-contrib.R,  3 Jul 16
#
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("VennDiagram")


pal_col=rainbow_hcl(3)


# This package used the grid package for its graphics
grid.newpage()
vp=viewport(width=0.4, height=0.4)
pushViewport(vp)

venn.plot = draw.triple.venn(
#	overrideTriple="blah", euler.d=FALSE, scaled=FALSE,
		area1 = 90,
		area2 = 75,
		area3 = 100,
		n12 = 20,
		n23 = 25,
		n13 = 35,
		n123 = 15,
		label.col=c("yellow", "green", "yellow", "red", "blue", "red", "yellow"),
		category = c("X_2", "X_1", "Y"),
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

