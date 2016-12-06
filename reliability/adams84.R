#
# template.R,  5 Nov 16
# Data from:
# Optimizing Preventive Service of Software Products
# Edward N. Adams
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


pal_col=rainbow(9)


adams=read.csv(paste0(ESEUR_dir, "reliability/adams84.csv.xz"), as.is=TRUE)


plot(adams$P1, adams$P2, type="l", log="xy", col=pal_col[1],
	xlab="Product usage time (years)", ylab="Percentage of reported faults\n")
lines(adams$P1, adams$P3, col=pal_col[2])
lines(adams$P1, adams$P4, col=pal_col[3])
lines(adams$P1, adams$P5, col=pal_col[4])
lines(adams$P1, adams$P6, col=pal_col[5])
lines(adams$P1, adams$P7, col=pal_col[6])
lines(adams$P1, adams$P8, col=pal_col[7])
lines(adams$P1, adams$P9, col=pal_col[8])
lines(adams$P1, adams$P10, col=pal_col[9])

# library("reshape2")
# adams_2=melt(adams, "P1")

# Explain 60% of the deviance...
# p_mod=glm(log(value+1e-6) ~ I(log(P1)^0.25), data=adams_2)
# p_mod=glm(log(value+1e-6) ~ log(P1)+I(log(P1)^0.5), data=adams_2)
# summary(p_mod)
# 
# x_vals=exp(1:11)
# pred=predict(p_mod, newdata=data.frame(P1=x_vals))
# points(x_vals, exp(pred))

