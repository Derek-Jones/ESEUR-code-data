#
# 10-1002_maint-task-data.R,  1 Aug 16
#
# Data from:
# An Empirical Study of Software Maintenance Tasks
# Magne J{\o}rgensen
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


library("simex")


pal_col=rainbow(3)

maint_all=read.csv(paste0(ESEUR_dir, "regression/10-1002_maint-task-data.csv.xz"), as.is=TRUE)

maint_all$ins_up=maint_all$INSERT+maint_all$UPDATE
maint_all$lins_up=log(maint_all$ins_up)

maint=subset(maint_all, EFFORT > 0.1)
maint=subset(maint, ins_up > 0.0)

plot(maint$ins_up, maint$EFFORT, log="xy", col=point_col,
	xlab="Lines added+updated", ylab="Effort (days)\n")

maint_mod=glm(EFFORT ~ lins_up, data=maint, family=gaussian(link="log"),
				x=TRUE, y=TRUE)

x_vals=exp(seq(1e-2, log(max(maint$ins_up)), length.out=20))

pred=predict(maint_mod, newdata=data.frame(lins_up=log(x_vals)), se.fit=TRUE)

lines(x_vals, exp(pred$fit), col=pal_col[1])
# lines(x_vals, exp(pred$fit+1.96*pred$se), col=pal_col[2])
# lines(x_vals, exp(pred$fit-1.96*pred$se), col=pal_col[2])


# maint_lmod=glm(log(EFFORT) ~ lins_up, data=maint)
# 
# pred=predict(maint_lmod, newdata=data.frame(lins_up=log(x_vals)), se.fit=TRUE)
# 
# lines(x_vals, exp(pred$fit), col="blue")
# lines(x_vals, exp(pred$fit+1.96*pred$se), col="green")
# lines(x_vals, exp(pred$fit-1.96*pred$se), col="green")

# The message: cannot find valid starting values: please specify some
# comes from glm.  In this case log EFFORT cannot be negative and so
# measurement.error has to be small enough so this does not happen.
# y_err=simex(maint_mod, SIMEXvariable="EFFORT",
#			measurement.error=maint$lins_up/6, asymptotic=FALSE)
# Should a vector of measurement.error be given???
# y_err=simex(maint_mod, SIMEXvariable="lins_up", measurement.error=sqrt(maint$lins_up)/4, asymptotic=FALSE)
y_err=simex(maint_mod, SIMEXvariable="lins_up", measurement.error=maint$lins_up/10, asymptotic=FALSE)

pred=predict(y_err, newdata=data.frame(lins_up=log(x_vals)), se.fit=TRUE)

lines(x_vals, exp(pred$fit), col=pal_col[3])
# lines(x_vals, exp(pred$fit+1.96*pred$se), col="yellow")
# lines(x_vals, exp(pred$fit-1.96*pred$se), col="yellow")


