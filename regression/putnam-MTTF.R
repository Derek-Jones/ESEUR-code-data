#
# putnam-MTTF.R, 22 Dec 15
#
# Data from:
# Measures for Excellence: Reliable software on time, within budget
# Lawrence H. Putnam and Ware Myers
# Figure 8.3
#
# Example from:
# Empirical Software Engineering using R
# Derek M. Jones

source("ESEUR_config.r")


pal_col=rainbow(3)

MTTF=read.csv(paste0(ESEUR_dir, "regression//putnam-MTTF.csv.xz"), as.is=TRUE)

log_mttf=log(MTTF)

# plot(MTTF, log="x", col=point_col,
#           xlab="Effective Source LOC x 1000", ylab="Mean Time to Fail (days)")

plot(MTTF, log="xy", col=point_col,
          xlab="Effective Source KLOC", ylab="Mean Time to Fail (days)\n")
lines(loess.smooth(MTTF$ESLOC, MTTF$MTTF, span=0.5, family="gaussian"), col="yellow")


mttf_fit=glm(MTTF ~ ESLOC, data=log_mttf)

mttf_pred=predict(mttf_fit)
lines(MTTF$ESLOC, exp(mttf_pred), col=pal_col[1])

# There are lots of non-integer values, so family=poisson cannot be used.
glm_fit=glm(MTTF ~ log(ESLOC), data=MTTF, family=gaussian(link="log"))
pred_ESLOC=seq(1, 2000, 10)
pred_mttf=predict(glm_fit, newdata=list(ESLOC=pred_ESLOC), type="link", se.fit=TRUE)

lines(pred_ESLOC, exp(pred_mttf$fit), col=pal_col[2])
lines(pred_ESLOC, exp(pred_mttf$fit+pred_mttf$se.fit*1.96), col=pal_col[3])
lines(pred_ESLOC, exp(pred_mttf$fit-pred_mttf$se.fit*1.96), col=pal_col[3])

