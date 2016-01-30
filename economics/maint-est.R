#
# maint-est.R, 25 Jan 16
#
# Data from:
#
# How accurately do engineers predict software maintenance tasks?
# Les Hatton
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("plyr")


# est_adapt,est_correct,est_perfect,act_adapt,act_correct,act_perfect,est_time,act_time
maint=read.csv(paste0(ESEUR_dir, "economics/exportdata.csv.xz"), as.is=TRUE)

plot_layout(1, 3)

plot(maint$est_time, maint$act_time, col=point_col,
	xlab="Estimated hours", ylab="Actual hours\n")

plot(jitter(maint$est_time), jitter(maint$act_time), col=point_col,
	xlab="Estimated hours", ylab="")

t=ddply(maint, .(est_time, act_time), nrow)
plot(t$est_time, t$act_time, cex=log(1+t$V1), pch=1, col=point_col,
	xlab="Estimated hours", ylab="")

brew_col=rainbow_hcl(3)

fit_maint=function(maint)
{
plot(jitter(maint$est_time), jitter(maint$act_time), col=point_col,
	xlab="Estimated hours", ylab="Actual hours")

e_mod=glm(act_time ~ est_time, data=maint, family=quasipoisson(link="identity"))
#e_mod=glm(act_time ~ est_time, data=maint, family=quasipoisson)

xbounds=seq(1, 40)

# e_pred=predict(e_mod, newdata=data.frame(est_time=xbounds), type="response", se.fit=TRUE)

# lines(xbounds, e_pred$fit, col="red")
# lines(xbounds, e_pred$fit+1.96*e_pred$se.fit, col="blue")
# lines(xbounds, e_pred$fit-1.96*e_pred$se.fit, col="blue")

return(e_mod)
}

# all_mod=fit_maint(maint)

# adapt_maint=subset(maint, est_adapt != 0)
# a_mod=fit_maint(adapt_maint)

# corr_maint=subset(maint, est_correct != 0)
# c_mod=fit_maint(corr_maint)

# perf_maint=subset(maint, est_perfect != 0)
# p_mod=fit_maint(perf_maint)

