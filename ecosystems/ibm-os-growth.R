#
# ibm-os-growth.R,  1 Jul 17
# Data from:
# SOFTWARE ENGINEERING Report on a conference sponsored by the {NATO} SCIENCE COMMITTEE
# Peter Naur and Brian Randell
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG IBM OS LOC


source("ESEUR_config.r")


plot_model=function(df, pos_val=4)
{
text(df$year[1], df$instructions[1]/(2^10), df$model[1], pos=pos_val)
}



ibm_os=read.csv(paste0(ESEUR_dir, "ecosystems/ibm-os-growth.csv.xz"), as.is=TRUE)

plot(ibm_os$year, ibm_os$instructions/(2^10), log="y", col=point_col,
	xlab="Year", ylab="Instructions (K)\n")

dummy=sapply(c(1, 3:9, 11:13), function(X) plot_model(ibm_os[X, ]))
dummy=sapply(c(2, 10, 14, 15), function(X) plot_model(ibm_os[X, ], 2))


