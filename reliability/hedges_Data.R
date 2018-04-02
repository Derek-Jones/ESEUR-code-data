#
# hedges_Data.R, 16 Mar 18
# Data from:
# Natural language of uncertainty: numeric hedge words
# Scott Ferson and Jason O'Rawe and Andrei Antonenko and Jack Siegrist and James Mickley and Christian C. Luhmann and Kari Sentz and Adam M. Finkel
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(4)


plot_Hedge=function(hedge_str, col_num)
{
about=subset(exp1, Hedge == hedge_str)
lines(sort(about$MinValue/about$ActValue), col=pal_col[col_num])
lines(sort(about$ActValue/about$MaxValue), lty=2, col=pal_col[col_num])
}


exp1=read.csv(paste0(ESEUR_dir, "reliability/hedges_Data-Exp2.csv.xz"), as.is=TRUE)


plot(0, type="n",
	xaxs="i", yaxs="i",
	xlim=c(1, 600), ylim=c(0.75, 1))


plot_Hedge("about", 1)
plot_Hedge("approximately", 2)
plot_Hedge("around", 3)
plot_Hedge("roughly", 4)

exp1$range=abs(exp1$MaxValue-exp1$MinValue)

plot(exp1$ActValue, exp1$range, log="xy")

h_mod=glm(log(range+1e-10) ~ Hedge+log(ActValue), data=exp1)
summary(h_mod)


