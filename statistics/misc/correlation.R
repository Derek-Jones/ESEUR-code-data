#
# correlation.R, 18 Apr 14
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


plot_cor=function(cor_req)
{
# The following only applies when both distributions are in  N(0, 1)
# Can change mean/variance in the final result if required.
a=function(c) return(sqrt((1-c)/(1+c)))

u=rnorm(200)
v=rnorm(200)

x=u+a(cor_req)*v
y=u-a(cor_req)*v

plot(x, y,
	col="brown",
	bty="n", xaxt="n", yaxt="n",
	main=paste0("correlation: ", signif(cor.test(x, y)$estimate, 2)),
	xlab="", ylab="")

}

plot_layout(2, 2)

plot_cor(0.98)
plot_cor(0.4)
plot_cor(-0.95)
plot_cor(-0.1)

