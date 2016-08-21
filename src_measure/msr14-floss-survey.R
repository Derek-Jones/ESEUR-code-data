#
# msr14-floss-survey.R, 13 Jan 16
#
# Data from:
#
# {FLOSS} 2013: {A} Survey Dataset about Free Software Contributors: Challenges for Curating, Sharing, and Combining
# Gregorio Robles and Laura Arjona Reina and Alexander Serebrenik and Bogdan Vasilescu and Jes{\'u}s M. Gonz{\'a}lez-Barahona
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("Matrix") # sparse.model.matrix is referenced by a function in quantreg
library("quantreg")


plot_quant=function(q_tau, col_str)
{
rq_mod=rqss(age_started ~ qss(year_started),
		data=year_time, tau=q_tau)

plot(rq_mod, add=TRUE, rug=FALSE, col=col_str,
	titles="")
}


pal_col=rainbow(3)


floss_dev=read.csv(paste0(ESEUR_dir, "src_measure/msr14-floss-survey.csv.xz"), as.is=TRUE)

floss_dev$year_started=as.numeric(floss_dev$I.started.in)
floss_dev$age_started=as.numeric(floss_dev$My.age.then.was.)

# hist(floss_dev$year_started, breaks=25)
# 
# hist(floss_dev$age_started, breaks=25)
# 
# hist(2014-floss_dev$year_started+floss_dev$age_started, breaks=30)

plot(floss_dev$year_started, floss_dev$age_started, col=point_col,
	xlab="Year started", ylab="Age when starting\n")

# lines(loess.smooth(floss_dev$year_started, floss_dev$age_started, span=0.5, family="gaussian"), col="red")

# age_mod=glm(year_started ~ age_started,
# 		data=floss_dev)

# qss freaks when passed NAs
year_time=na.omit(data.frame(year_started=floss_dev$year_started,
				age_started=floss_dev$age_started))

plot_quant(0.25, pal_col[3])
plot_quant(0.5, pal_col[1])
plot_quant(0.75, pal_col[2])

legend(x="topleft", legend=c("0.75 quartile", "0.5 quartile", "0.25 quartile"),
		bty="n", fill=pal_col[c(2, 1, 3)], cex=1.2)

