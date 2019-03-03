#
# LandyGuayMarghetis-PBR.R, 11 Feb 19
# Data from:
# Bias and ignorance in demographic perception
# D. Landy and B. Guay and T. Marghetis
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG experiment human subject

source("ESEUR_config.r")


library("plyr")


logodds=function(vec)
{
vec[vec==0]=1e-10
vec[vec==1]=1-1e-10

return(log(vec/(1-vec)))
}


unlogodds=function(vec)
{
return(exp(vec)/(1+exp(vec)))
}


plot_type=function(df)
{
points(df$actual_prop, df$estimate_prop, col=df$col_str)
}


lgm=read.csv(paste0(ESEUR_dir, "developers/LandyGuayMarghetis-PBR.csv.xz"), as.is=TRUE)

lgm$estimate_prop=lgm$estimate/100
lgm$actual_prop=lgm$actual/100

u_type=unique(lgm$type)
pal_col=rainbow(length(u_type))
lgm$col_str=mapvalues(lgm$type, u_type, pal_col)

plot(-1, type="n",
	xlim=c(0, 1), ylim=c(0, 1),
	xlab="Actual proportion", ylab="Estimated proportion\n")
lines(c(0, 1), c(0, 1), col="grey")
legend(x="bottomright", legend=u_type, bty="n", fill=pal_col, cex=1.2)

d_ply(lgm, .(type), plot_type)

lgm$lo_act=logodds(lgm$actual_prop)
lgm$lo_est=logodds(lgm$estimate_prop)

phi_mod=nls(lo_est ~ a*lo_act+(1-a)*b, data=lgm,
			start=list(a=0.3, b=0.4))
# summary(phi_mod)

lo_act_range=seq(logodds(1e-3), logodds(1-1e-3), by=0.5)
pred=predict(phi_mod, newdata=data.frame(lo_act=lo_act_range))

lines(unlogodds(lo_act_range), unlogodds(pred), col=point_col)


