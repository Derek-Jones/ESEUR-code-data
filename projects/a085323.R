#
# a085323.R,  5 Oct 19
# Data from:
# Evaluation of software life cycle data from the PAVE PAWS project
# Bill Curtis and Sylvia B. Sheppard and Elizabeth Kruesi
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG

source("ESEUR_config.r")


library("plyr")

pal_col=rainbow(5)


# Total person hours and mean date (data was extracted so date values
# contain uncertainty).
sum_mean=function(df)
{
return(data.frame(total=sum(df$P_hours), M_mean=mean(df$Month)))
}


proj=read.csv(paste0(ESEUR_dir, "projects/a085323.csv.xz"), as.is=TRUE)

proj$int_month=trunc(proj$Month)

P_total=ddply(proj, .(int_month), sum_mean)

plot(proj$Month, proj$P_hours, type="n", yaxs="i",
	ylim=range(P_total$total)+50,
	xlab="Elapsed time (months)", ylab="Effort (person hours)\n")

d_ply(proj, .(Project), function(df) lines(df$Month, df$P_hours, col=pal_col[df$Project]))

lines(P_total$M_mean, P_total$total, col="grey")

# 
# ray_mod=nls(total ~ k*a*M_mean*exp(-a*M_mean*M_mean), data=P_total, trace=TRUE,
# 			start=list(k=40000, a=0.02))
# summary(ray_mod)
# 
# pred=predict(ray_mod)
# lines(P_total$M_mean, pred, col="green")


