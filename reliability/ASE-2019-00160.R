#
# ASE-2019-00160.R,  6 Jun 20
# Data from:
# Empirical Study of {Python} Call Graph
# Yu Li
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG python_tool python_call-graph tool_accuracy


source("ESEUR_config.r")


library("VennDiagram")


pal_col=rainbow(4)


# This package uses the grid package for its graphics
grid.newpage()
vp=viewport(width=0.4, height=0.4)
pushViewport(vp)

venn.plot = draw.quad.venn(
		area1 = 254+30359+1193+2248+7791+1287+50+125,
		area2 = 2184+367+4065+7791+52+1287+50+125,
		area3 = 727+254+879+1193+4065+7791+52+50,
		area4 = 16076+879+2184+1193+4065+7791+2248+1287,
		n12 = 7791+1287+50+125,
		n13 = 254+1193+7791+50,
		n14 = 1193+2248+7791+1287,
		n23 = 4065+7791+52+50,
		n24 = 2184+4065+7791+1287,
		n34 = 879+1193+4065+7791,
		n123 = 7791+50,
		n124 = 7791+1287,
		n134 = 1193+7791,
		n234 = 4065+7791,
		n1234 = 7791,
		category = c("Callgraph", "Understand", "Code2flow", "Pyan"),
		fill = pal_col,
		alpha=0.4,
		col="grey",
		# lty = "dashed",
		lwd=1.5,
		cex = 1,
		cat.cex = 1,
		cat.col = pal_col,
		# print.mode=c("raw", "percent"),
		# sigdigs=1
		)

grid.draw(venn.plot)
popViewport()


