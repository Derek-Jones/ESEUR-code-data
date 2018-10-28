#
# maint-est.R,  9 Jul 18
#
# Data from:
# How accurately do engineers predict software maintenance tasks?
# Les Hatton
#
# Example from:
# Evidence-based Software Engineering: based on the publicly available data
# Derek M. Jones
#
# TAG predict effort maintenance


source("ESEUR_config.r")


library("plyr")


plot_layout(3, 1)
brew_col=rainbow_hcl(3)


# est_adapt,est_correct,est_perfect,act_adapt,act_correct,act_perfect,est_time,act_time
maint=read.csv(paste0(ESEUR_dir, "economics/exportdata.csv.xz"), as.is=TRUE)

plot(maint$est_time, maint$act_time, col=point_col,
	xlab="", ylab="Actual hours\n")

plot(jitter(maint$est_time), jitter(maint$act_time), col=point_col,
	xlab="Estimated hours", ylab="Actual hours\n")

t=ddply(maint, .(est_time, act_time), nrow)
plot(t$est_time, t$act_time, cex=log(1+t$V1), pch=1, col=point_col,
	xlab="", ylab="Actual hours\n")

# est_mod=glm(log(act_time) ~ log(est_time), data=maint)
# est_mod=glm(log(act_time) ~ log(est_time)+I(log(est_time)^2), data=maint)
# summary(est_mod)



fit_maint=function(maint)
{
plot(jitter(maint$est_time), jitter(maint$act_time), col=point_col,
	xlab="Estimated hours", ylab="Actual hours")

lines(loess.smooth(maint$est_time, maint$act_time, span=0.3), col=loess_col)

e_mod=glm(act_time ~ est_time, data=maint, family=quasipoisson(link="identity"))
#e_mod=glm(act_time ~ est_time, data=maint, family=quasipoisson)

xbounds=0:40

e_pred=predict(e_mod, newdata=data.frame(est_time=xbounds), type="response", se.fit=TRUE)

lines(xbounds, e_pred$fit, col="red")
lines(xbounds, e_pred$fit+1.96*e_pred$se.fit, col="blue")
lines(xbounds, e_pred$fit-1.96*e_pred$se.fit, col="blue")

return(e_mod)
}

# all_mod=fit_maint(maint)

# adapt_maint=subset(maint, est_adapt != 0)
# a_mod=fit_maint(adapt_maint)

# corr_maint=subset(maint, est_correct != 0)
# c_mod=fit_maint(corr_maint)

# perf_maint=subset(maint, est_perfect != 0)
# p_mod=fit_maint(perf_maint)

