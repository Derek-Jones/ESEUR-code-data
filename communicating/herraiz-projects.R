#
# herraiz-projects.R, 15 Jul 16
#
# Data from:
# A statistical examination of the properties and evolution of libre software
# Israel Herraiz Tabernero
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones


source("ESEUR_config.r")


plot_layout(2, 1)

proj_inf=read.csv(paste0(ESEUR_dir, "communicating/herraiz-projects.tsv.xz"),
			as.is=TRUE, sep="\t")

proj_inf=subset(proj_inf, Files > 0)

plot(proj_inf$Files, proj_inf$SLOC, log="xy", col=point_col,
	xlab="Files", ylab="SLOC")


# Bug in support for log argument :-(
smoothScatter(log(proj_inf$Files), log(proj_inf$SLOC),
	xlab="log(Files)", ylab="log(SLOC)")


# library("hexbin")
# 
# loc_bin=hexbin(log(proj_inf$Files), log(proj_inf$SLOC), xbins=50)
# plot(loc_bin,
# 	xlab="log(Files)", ylab="log(SLOC)")
# 
# 
# 
# xyplot(Files ~ SLOC, data=proj_inf, panel=panel.hexbinplot,
#	col=point_col, pch=point_pch, type="b",
# 	scales=list(x=list(log=10), y=list(log=10)))

