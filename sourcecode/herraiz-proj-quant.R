#
# herraiz-proj-quant.R, 17 Mar 20
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


library("quantreg")

pal_col=rainbow(3)


quant_fit=function(tau_val, col_str)
{
rq_mod=rq(log(SLOC) ~ log(Files), data=proj_inf, tau=tau_val)
pred=predict(rq_mod, newdata=data.frame(Files=x_bounds))

lines(log(x_bounds), pred, col=col_str)

return(rq_mod)
}


proj_inf=read.csv(paste0(ESEUR_dir, "sourcecode/herraiz-projects.tsv.xz"),
			as.is=TRUE, sep="\t")

proj_inf=subset(proj_inf, Files > 0)

plot(log(proj_inf$Files), log(proj_inf$SLOC), col=densCols(log(proj_inf$Files), log(proj_inf$SLOC)),
	pch=20,
	xlab="log(Files)", ylab="log(SLOC)\n")

legend(x="bottomright", legend=c("50% quantile", "95% quantile", "5% quantile"), bty="n", fill=pal_col, cex=1.2)

x_bounds=exp(seq(0, log(1e5), by=0.1))

rq05_mod=quant_fit(0.05, pal_col[3])
rq50_mod=quant_fit(0.5, pal_col[1])
rq95_mod=quant_fit(0.95, pal_col[2])

# exp(coef(rq_mod))[1]
# coef(rq_mod)[2]
# 
# (exp(coef(rq95_mod))-exp(coef(rq_mod)))[1]
# (exp(coef(rq_mod))-exp(coef(rq05_mod)))[1]
# (coef(rq95_mod)-coef(rq_mod))[2]
# (coef(rq_mod)-coef(rq05_mod))[2]

