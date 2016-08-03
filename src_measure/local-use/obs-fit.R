#
# obs-fit.R, 13 Jul 16
#
# Data from:
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")

library("plyr")
library("mgcv")


norm_occurrences=function(df)
{
df$norm_occur=df$occurrences/sum(df$occurrences)

return(df)
}


loc_acc=read.csv(paste0(ESEUR_dir, "src_measure/local-use/acc-per-obj.csv.xz"), as.is=TRUE)

loc_acc=ddply(loc_acc, .(total.access), norm_occurrences)

# When total.acc > 150 the data starts to get a bit sparse
common_loc=subset(loc_acc, total.access <= 150)
around_100=subset(loc_acc, (total.access >= 95) & (total.access <= 105))
above_10=subset(loc_acc, (total.access >= 10))

locg_mod=gam(norm_occur ~ s(object.access, total.access, k=75),
		 data=common_loc, family=Gamma)

summary(locg_mod)
gam.check(locg_mod)

locp_mod=gam(norm_occur ~ s(object.access, k=50)+s(total.access, k=50),
		 data=common_loc, family=Gamma)

summary(locp_mod)
gam.check(locp_mod)

vis.gam(locg_mod, plot.type="contour")


loc100_mod=gam(norm_occur ~ s(object.access, k=40),
		 data=around_100, family=Gamma)

plot(around_100$object.access, around_100$norm_occur,
	 xlim=c(1, 60), ylim=c(0, 0.5),
	xlab="Accesses", ylab="Occurrences (nomalised)")
lines(predict(loc100_mod, newdata=data.frame(object.access=1:100), type="response"),
	col="red")


