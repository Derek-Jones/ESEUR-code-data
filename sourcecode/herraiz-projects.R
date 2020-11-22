#
# herraiz-projects.R, 18 Jan 20
#
# Data from:
# A statistical examination of the properties and evolution of libre software
# Israel Herraiz Tabernero
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG SLOC project_files project_SLOC project_evolution

source("ESEUR_config.r")


proj_inf=read.csv(paste0(ESEUR_dir, "sourcecode/herraiz-projects.tsv.xz"),
			as.is=TRUE, sep="\t")

proj_inf=subset(proj_inf, Files > 0)

# plot(proj_inf$Files, proj_inf$SLOC, log="xy", col=point_col,
# 	xlab="Files", ylab="SLOC")

# sf_mod=glm(log(SLOC) ~ log(Files), data=proj_inf)
# summary(sf_mod)

# Bug in support for log argument :-(
smoothScatter(log(proj_inf$Files), log(proj_inf$SLOC), axes=FALSE,
	xlab="Files", ylab="SLOC")

xbounds=c(1, 10, 100, 1000, 10000)
ybounds=c(1e1, 1e3, 1e5, 1e7)
axis(1, at=log(xbounds), lab=xbounds)
axis(2, at=log(ybounds), lab=ybounds)


# library("quantreg")
# 
# # plot(log(proj_inf$Files), log(proj_inf$SLOC), col=densCols(log(proj_inf$Files), log(proj_inf$SLOC)), pch=20)
# 
# x_bounds=exp(seq(0, log(1e5), by=0.1))
# 
# rq05_mod=rq(log(SLOC) ~ log(Files), data=proj_inf, tau=0.05)
# rq95_mod=rq(log(SLOC) ~ log(Files), data=proj_inf, tau=0.95)
# rq_mod=rq(log(SLOC) ~ log(Files), data=proj_inf, tau=0.5)
# # pred=predict(rq_mod, newdata=data.frame(Files=x_bounds))
# # lines(x_bounds, exp(pred), col="green")
# 
# exp(coef(rq_mod))[1]
# coef(rq_mod)[2]
# 
# (exp(coef(rq95_mod))-exp(coef(rq_mod)))[1]
# (exp(coef(rq_mod))-exp(coef(rq05_mod)))[1]
# (coef(rq95_mod)-coef(rq_mod))[2]
# (coef(rq_mod)-coef(rq05_mod))[2]
# 
# 
# # library("hexbin")
# # 
# # loc_bin=hexbin(log(proj_inf$Files), log(proj_inf$SLOC), xbins=50)
# # plot(loc_bin,
# # 	xlab="log(Files)", ylab="log(SLOC)")
# # 
# # 
# # 
# # xyplot(Files ~ SLOC, data=proj_inf, panel=panel.hexbinplot,
# #	col=point_col, pch=point_pch, type="b",
# # 	scales=list(x=list(log=10), y=list(log=10)))
# 
