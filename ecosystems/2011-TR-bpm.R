#
# 2011-TR-bpm.R, 20 May 20
#
# Data from:
# An Empirical Study on Consistency Management of Business and {IT} Process Models
# Mois{\'e}s Castelo Branco and Yingfei Xiong and Krzysztof Czarnecki and Jochen K{\"u}ster and Hagen V{\"o}lzer
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG business_change-request

source("ESEUR_config.r")


pal_col=rainbow(4)

P1=read.csv(paste0(ESEUR_dir, "ecosystems/P1_Change_Requests.tsv.xz"), sep="\t", as.is=TRUE)

P1$MONTH=as.Date(paste0("01-", P1$MONTH), format="%d-%b/%Y")

ybounds=c(0, max(P1$NONE))

plot_change=function(kind, col_num)
{
lines(P1$MONTH, kind, type="l", col=pal_col[col_num])
}

plot(P1$MONTH, P1$NONE, type="n",
	xaxs="i", yaxs="i",
	ylim=ybounds,
	xlab="Date", ylab="Changes\n")
plot_change(P1$NONE, 1)
plot_change(P1$BPEL, 2)
plot_change(P1$BOTH, 3)
plot_change(P1$BPMN, 4)

legend(x="topright", legend=c("Neither", "IT only", "Business/IT", "Business only"),
			bty="n", fill=pal_col, cex=1.2)

