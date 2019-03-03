#
# hedges_Data.R, 25 Feb 19
# Data from:
# Natural language of uncertainty: numeric hedge words
# Scott Ferson and Jason O'Rawe and Andrei Antonenko and Jack Siegrist and James Mickley and Christian C. Luhmann and Kari Sentz and Adam M. Finkel
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG number language word-hedge experiment human


source("ESEUR_config.r")


library("plyr")


# plot_layout(2, 1)
pal_col=rainbow(4)


plot_Hedge=function(hedge_str, col_num)
{
about=subset(exp1, Hedge == hedge_str)
lines(sort(about$MinValue/about$ActValue), col=pal_col[col_num])
lines(sort(about$ActValue/about$MaxValue), lty=2, col=pal_col[col_num])
}


plot_uncertainty=function(hedge_str, col_num)
{
resp=subset(exp1, Hedge == hedge_str)
rel_unc=count((resp$MinValue-resp$ActValue)/resp$MinValue)
lines(rel_unc$x, cumsum(rel_unc$freq)/nrow(resp), col=pal_col[col_num])

rel_unc=count((resp$MaxValue-resp$ActValue)/resp$MaxValue)
lines(rel_unc$x, cumsum(rel_unc$freq)/nrow(resp), col=pal_col[col_num], lty=2)

}


exp1=read.csv(paste0(ESEUR_dir, "developers/hedges_Data-Exp2.csv.xz"), as.is=TRUE)

# Assume that switched values is an unintentional mistake
sw=which(exp1$MinValue > exp1$MaxValue)
t=exp1$MinValue[sw]
exp1$MinValue[sw]=exp1$MaxValue[sw]
exp1$MaxValue[sw]=t

# If min/max differs from actual by a factor of ten, then
# subject is treated as having unintentionally missed a digit or added one.
# Happens relatively few times, so don't try to add/remove a digit.
exp1=subset(exp1, ActValue/MinValue < 10)
exp1=subset(exp1, ActValue/MaxValue > 0.1)

# plot(0, type="n",
# 	xaxs="i", yaxs="i",
# 	xlim=c(1, 600), ylim=c(0.75, 1))
# 
# 
# plot_Hedge("about", 1)
# plot_Hedge("approximately", 2)
# plot_Hedge("around", 3)
# plot_Hedge("roughly", 4)

plot(0, type="n",
	xaxs="i", yaxs="i",
	xlim=c(-1, 1), ylim=c(0, 1),
	xlab="Relative uncertainty", ylab="Cumulative probability\n")

plot_uncertainty("almost", 1)
plot_uncertainty("below", 2)
plot_uncertainty("at_most", 3)
plot_uncertainty("no_more_than", 4)

legend(x="left", legend=c("almost", "below", "at most", "no more than"), bty="n", fill=pal_col, cex=1.2)

# plot(0, type="n",
# 	xaxs="i", yaxs="i",
# 	xlim=c(-1, 1), ylim=c(0, 1),
# 	xlab="Relative uncertainty", ylab="Probability\n")

plot_uncertainty("above", 1)
plot_uncertainty("over", 2)
plot_uncertainty("at_least", 3)
plot_uncertainty("no_less_than", 4)

legend(x="right", legend=c("above", "over", "at least", "no less than"), bty="n", fill=pal_col, cex=1.2)

# exp1$range=abs(exp1$MaxValue-exp1$MinValue)
# exp1$is_ten=grepl("0$", as.character(exp1$ActValue))
# exp1$is_five=grepl("5$", as.character(exp1$ActValue))
# exp1$act_digits=nchar(as.character(exp1$ActValue))
# 
# plot(exp1$ActValue, exp1$range, log="xy")
# 
# exp_nz=subset(exp1, range != 0)
# 
# h_mod=glm(log(range) ~ Hedge+act_digits+is_ten+is_five+log(ActValue), data=exp_nz)
# summary(h_mod)


