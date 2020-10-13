#
# ibm-os-growth.R, 22 Sep 20
# Data from:
# SOFTWARE ENGINEERING Report on a conference sponsored by the {NATO} SCIENCE COMMITTEE
# Peter Naur and Brian Randell
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG IBM_OS OS_LOC LOC_evolution


source("ESEUR_config.r")


pal_col=rainbow(3)


plot_model=function(df, pos_val=4)
{
text(df$year[1], df$instructions[1]/(2^10), df$model[1], pos=pos_val, col=pal_col[3])
}



ibm_os=read.csv(paste0(ESEUR_dir, "ecosystems/ibm-os-growth.csv.xz"), as.is=TRUE)

plot(ibm_os$year, ibm_os$instructions/(2^10), log="y", col=pal_col[1],
	xlab="Year", ylab="Instructions (K)\n")

ins_mod=glm(log(instructions) ~ year, data=ibm_os)
# summary(ins_mod)

pred=predict(ins_mod)
lines(ibm_os$year, exp(pred)/(2^10), col=pal_col[2])

dummy=sapply(c(1, 3:9, 11:13), function(X) plot_model(ibm_os[X, ]))
dummy=sapply(c(2, 10, 14, 15), function(X) plot_model(ibm_os[X, ], 2))

