#
# Regression-models.R, 27 Dec 15
#
# Data from:
# Regression Models of Software Development Effort Estimation Accuracy and Bias
# Magne J{\o}rgensen
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(4)

est_info=read.csv(paste0(ESEUR_dir, "economics/Regression-models.csv.xz"), as.is=TRUE)

plot(est_info$Estimated.effort, est_info$Actual.effort, log="xy", col=point_col,
	xlim=c(5, max(est_info$Estimated.effort)),
	ylim=c(5, max(est_info$Actual.effort)),
	xlab="Estimated effort (hours)", ylab="Actual effort\n")

est_range=5:500
log_x=log(est_range)

lines(loess.smooth(est_info$Estimated.effort, est_info$Actual.effort, span=0.5, family="gaussian"),
	 col="yellow")

est_info$log_estimated=log(est_info$Estimated.effort)
# est_mod=glm(Actual.effort ~ log_estimated, family=quasipoisson(link="log"), data=est_info)
est_mod=glm(Actual.effort ~ log_estimated, family=Gamma(link="log"), data=est_info)

log_x=log(est_range)

pred=predict(est_mod, newdata=data.frame(log_estimated=log_x), type="link", se.fit=TRUE)

lines(est_range, exp(pred$fit), col=pal_col[1])
lines(est_range, exp(pred$fit+1.96*pred$se.fit), col=pal_col[2])
lines(est_range, exp(pred$fit-1.96*pred$se.fit), col=pal_col[2])

est_mod=glm(log(Actual.effort) ~ log_estimated, family=gaussian, data=est_info)
pred=predict(est_mod, newdata=data.frame(log_estimated=log_x), type="link", se.fit=TRUE)

lines(est_range, exp(pred$fit), col=pal_col[3])
lines(est_range, exp(pred$fit+1.96*pred$se.fit), col=pal_col[4])
lines(est_range, exp(pred$fit-1.96*pred$se.fit), col=pal_col[4])

