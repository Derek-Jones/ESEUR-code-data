#
# 1611-09187a.R,  8 Nov 19
# Data from:
# Benjamin Danglot and Philippe Preux and Benoit Baudry and Martin Monperrus
# Correctness Attraction: {A} Study of Stability of Software Behavior Under Runtime Perturbation
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG runtime_perturbation

source("ESEUR_config.r")


library("plyr")
library("vioplot")


normalise_pert=function(df)
{
ao=subset(df, Perturb_str == "AddOne")

# Percentage of success, as an integer
perc_succ=trunc(100*ao$Success/ao$Num_Perturb)
perc_succ[is.nan(perc_succ)]=0
perc_succ[is.infinite(perc_succ)]=0

# Weight location by percentage successes
NormLoc=rep(100*ao$IndexLoc/max(ao$IndexLoc),
		times=perc_succ)

return(data.frame(Program=df$Program[1], NormLoc))
}


ptb=read.csv(paste0(ESEUR_dir, "reliability/1611-09187a.csv.xz"), as.is=TRUE)

subjects=c("quicksort", "zip", "sudoku", "md5", "rsa", "rc4", "canny", "lcs", "laguerre", "linreg")

ptb=subset(ptb, Program %in% subjects)

vp=ddply(ptb, .(Program), normalise_pert)


pal_col=rainbow(length(unique(vp$Program)))

vioplot(NormLoc ~ Program, data=vp,
	h=1.1,
	horizontal=TRUE,
        col=pal_col, border=pal_col,
	xaxs="i",
	xlab="Perturbation location (normalised)", ylab="")

